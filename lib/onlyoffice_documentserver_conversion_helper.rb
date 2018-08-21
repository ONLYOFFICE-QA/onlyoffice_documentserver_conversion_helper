require 'jwt'
require 'net/http'
require 'securerandom'
require 'timeout'
require_relative 'onlyoffice_documentserver_conversion_helper/version'

# Stuff for working with conversion service
# See: https://api.onlyoffice.com/editors/conversionapi
module OnlyofficeDocumentserverConversionHelper
  # ==== Examples
  # ConvertFileData.new('https://doc-linux.teamlab.info').perform_convert('http://testrail-nct.tk/files/convertation_select/googerd.docx')
  # ConvertFileData.new('https://doc-linux.teamlab.info').perform_convert({:url=>'http://testrail-nct.tk/files/convertation_select/googerd.docx'})
  # ConvertFileData.new('https://doc-linux.teamlab.info').perform_convert({:url=>'http://testrail-nct.tk/files/convertation_select/googerd.docx', :outputtype => 'pdf'})
  class ConvertFileData
    attr_accessor :file_url
    attr_accessor :key
    attr_writer :input_filetype
    attr_accessor :output_file_type

    DOCUMENT_EXTENSIONS = %w[TXT HTML HTM ODT DOCT DOCX RTF DOC PDF].freeze
    SPREADSHEET_EXTENSIONS = %w[XLS XLSX ODS XLST].freeze
    PRESENTATION_EXTENSIONS = %w[PPT PPTX PPTT ODP].freeze

    def initialize(server_path,
                   jwt_key: 'jwt_key',
                   jwt_header: 'AuthorizationJwt',
                   jwt_prefix: 'Bearer',
                   timeout: 300)
      @server_path = server_path
      @jwt_key = jwt_key
      @jwt_header = jwt_header
      @jwt_prefix = jwt_prefix
      @timeout = timeout
    end

    def output_file_type_auto
      return 'docx' if DOCUMENT_EXTENSIONS.include?(@input_filetype.upcase)
      return 'xlsx' if SPREADSHEET_EXTENSIONS.include?(@input_filetype.upcase)
      return 'pptx' if PRESENTATION_EXTENSIONS.include?(@input_filetype.upcase)
    end

    def key_auto
      SecureRandom.uuid
    end

    def input_filetype
      File.extname(@file_url).delete('.')
    end

    def convert_url
      "#{@server_path}/ConvertService.ashx"
    end

    def autocomplete_missing_params(params)
      params[:key] = key_auto unless params.key?(:key)
      params[:outputtype] = output_file_type_auto unless params.key?(:outputtype)
      params[:filetype] = input_filetype unless params.key?(:filetype)
      params
    end

    # @return [String] with url to result file
    # @param [String] data is a response body
    # @param [String] file_format is a format of result file
    # Method will get link from response body. Link start from 'https', and end from result file format
    def get_url_from_responce(data, file_format)
      res_result = /(http|https).*(#{file_format})/.match(data)
      CGI.unescapeHTML(res_result.to_s)
    end

    def add_jwt_data(request)
      payload_to_encode = { 'payload' => '{}' }
      jwt_encoded = JWT.encode payload_to_encode, @jwt_key
      request[@jwt_header] = "#{@jwt_prefix} #{jwt_encoded}"
    end

    def request(convert_url, params)
      uri = URI(convert_url)
      req = Net::HTTP::Post.new(uri)
      req.body = params.to_json
      add_jwt_data(req)
      http = Net::HTTP.new(uri.host, uri.port)
      http.read_timeout = @timeout
      http.use_ssl = true if uri.scheme == 'https'
      send_request(http, req)
    end

    # sending request every 5 second within @timeout
    # responce will contain 504 if
    # return responce body
    def send_request(http, req)
      Timeout.timeout(@timeout) do
        (@timeout / 5).times do
          responce = http.request(req)
          return responce.body unless responce.code == '504'
          sleep 5
        end
      end
    end

    # @return [Hash] with usl for download file after conversion and response data
    # @param [Hash] args collect all parameters of request OR [String] if you not need to use advensed params and want to set all etc params automaticly.
    # All args, except of :url and if it is [Hash], will be attache in end of request
    # ==== Examples
    # perform_convert('https://google.com/filename.docx')
    # perform_convert({:url => 'https://google.com/filename.docx'})
    # perform_convert({:url => 'https://google.com/filename.docx',
    #                 :key=>'askjdhaskdasdasdi',
    #                 :outputtype => 'pdf'})
    def perform_convert(args = {})
      args = { url: args } if args.is_a?(String)
      raise 'Parameter :url with link on file is necessary!!' if args[:url].nil? || args.nil?
      @file_url = args[:url]
      @input_filetype = File.extname(@file_url).delete('.')
      advanced_params = autocomplete_missing_params(args)
      data = request(convert_url, advanced_params)
      url = get_url_from_responce(data, advanced_params[:outputtype])
      { url: url, data: data }
    end
  end
end
