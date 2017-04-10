require 'tempmailru/host'
require 'net/http'
require 'json'

module TempMailRu
  class Api
    attr_accessor :email

    def initialize(email = nil, protocol = "http")
      @protocol = protocol
      @url = "#{protocol}://#{TempMailRu::HOST}"
      @email = email
    end

    def send_request(path)
      begin
        request_data = {}

        uri = URI.parse("#{@url}/#{path}/format/json")

        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = true if @protocol == 'https'

        request = Net::HTTP::Get.new(uri.request_uri)

        response = http.request(request)

        if response.code.to_i == 401
          return send_request(path)
        else
          request_data[:data] = JSON.parse(response.body, symbolize_names: true)
          request_data[:http_code] = response.code
        end
      rescue Exception => e
        raise "Exception \n message: #{e.message} \n backtrace: #{e.backtrace}"
      end

      handle_result(request_data)
    end
    protected :send_request

    def domains
      send_request("request/domains")[:data]
    end

    def handle_result(data)
      unless data[:http_code].to_i == 200
        data[:is_error] = true
      end
      data
    end
    protected :handle_result

    def inbox
      hash = Digest::MD5.hexdigest(@email)
      send_request("request/mail/id/#{hash}")[:data]
    end

    def source
      hash = Digest::MD5.hexdigest(@email)
      send_request("request/source/id/#{hash}")[:data]
    end

    def delete
      hash = Digest::MD5.hexdigest(@email)
      send_request("request/delete/id/#{hash}")[:data]
    end
  end
end
