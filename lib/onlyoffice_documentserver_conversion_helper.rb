# frozen_string_literal: true

require 'jwt'
require 'net/http'
require 'securerandom'
require 'timeout'
require_relative 'onlyoffice_documentserver_conversion_helper/xml_responce_parser'
require_relative 'onlyoffice_documentserver_conversion_helper/version'

# Stuff for working with conversion service
# See: https://api.onlyoffice.com/editors/conversionapi
module OnlyofficeDocumentserverConversionHelper
  # ==== Examples
  # converter = ConvertFileData.new('https://server')
  # converter.perform_convert('http://files/googerd.docx')
  # converter.perform_convert({:url=>'http://files/googerd.docx'})
  # converter.perform_convert({:url=>'http://files/googerd.docx',
  #                            :outputtype => 'pdf'})
  class ConvertFileData
    # @return [String] file_url to convert
    attr_accessor :file_url
    # @return [String] key for convert operation
    attr_accessor :key
    # @return [String] input_filetype format
    attr_writer :input_filetype
    # @return [String] output_file_type format
    attr_accessor :output_file_type

    # @return [Array<String>] list of text formats
    DOCUMENT_EXTENSIONS = %w[TXT HTML HTM ODT DOCT DOCX RTF DOC PDF].freeze
    # @return [Array<String>] list of spreadsheet formats
    SPREADSHEET_EXTENSIONS = %w[XLS XLSX ODS XLST].freeze
    # @return [Array<String>] list of presentation formats
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

    # Auto detect output file format
    # @return [String] result format
    def output_file_type_auto
      return 'docx' if DOCUMENT_EXTENSIONS.include?(@input_filetype.upcase)
      return 'xlsx' if SPREADSHEET_EXTENSIONS.include?(@input_filetype.upcase)
      return 'pptx' if PRESENTATION_EXTENSIONS.include?(@input_filetype.upcase)
    end

    # @return [String] random generated key
    def key_auto
      SecureRandom.uuid
    end

    # Get input file name from url
    # @return [String] result file name
    def input_filetype
      File.extname(@file_url).delete('.')
    end

    # @return [String] convert service url
    def convert_url
      "#{@server_path}/ConvertService.ashx"
    end

    # Complete missing params
    # @param [Hash] params manually defined
    # @return [Hash] filled params hash
    def autocomplete_missing_params(params)
      params[:key] = key_auto unless params.key?(:key)
      params[:outputtype] = output_file_type_auto unless params.key?(:outputtype)
      params[:filetype] = input_filetype unless params.key?(:filetype)
      params
    end

    # Add jwt data to request
    # @param [Net::HTTP::Post] request to add data
    # @return [Net::HTTP::Post] request with JWT
    def add_jwt_data(request)
      payload_to_encode = { 'payload' => JSON.parse(request.body) }
      jwt_encoded = JWT.encode payload_to_encode, @jwt_key
      request[@jwt_header] = "#{@jwt_prefix} #{jwt_encoded}"
    end

    # Make request
    # @param [String] convert_url to call
    # @param [Hash] params with options
    # @return [String] body of responce
    def request(convert_url, params)
      uri = URI(convert_url)
      req = Net::HTTP::Post.new(uri)
      req.body = params.to_json
      add_jwt_data(req)
      http = Net::HTTP.new(uri.host, uri.port)
      http.read_timeout = @timeout
      http.use_ssl = (uri.scheme == 'https')
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

    # @return [Hash] with usl for download file
    # after conversion and response data
    # @param [Hash] args collect all parameters of request
    #   OR [String] if you not need to use advenced params
    # and want to set all etc params automaticly.
    # All args, except of :url and if it is [Hash],
    # will be attache in end of request
    # ==== Examples
    # perform_convert('https://example.com/filename.docx')
    # perform_convert({:url => 'https://example.com/filename.docx'})
    # perform_convert({:url => 'https://google.com/filename.docx',
    #                  :key=>'askjdhaskdasdasdi',
    #                  :outputtype => 'pdf'})
    def perform_convert(args = {})
      args = { url: args } if args.is_a?(String)
      raise 'Parameter :url with link on file is necessary!!' if args[:url].nil? || args.nil?

      @file_url = args[:url]
      @input_filetype = File.extname(@file_url).delete('.')
      advanced_params = autocomplete_missing_params(args)
      data = request(convert_url, advanced_params)
      url = XmlResponceParser.new(data, advanced_params[:outputtype]).result_url
      { url: url, data: data }
    end
  end
end
