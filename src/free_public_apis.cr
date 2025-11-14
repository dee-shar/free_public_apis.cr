require "json"
require "http/client"

class FreePublicApis
  API_PATH = "api"
  def initialize
    @headers = HTTP::Headers {
      "Content-Type" => "application/json",
      "User-Agent" => "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36"
    }
    uri = URI.parse("https://www.freepublicapis.com")
    @http_client = HTTP::Client.new(uri)
  end

  def get_random_api() : JSON::Any
    JSON.parse(@http_client.get("/#{API_PATH}/random", headers: @headers).body)
  end

  def get_api(api_id : Int32) : JSON::Any
    JSON.parse(@http_client.get("/#{API_PATH}/apis/#{api_id}", headers: @headers).body)
  end

  def get_apis(limit : Int32 = 10, sort : String = "best") : JSON::Any
    JSON.parse(
      @http_client.get("/#{API_PATH}/apis?limit=#{limit}&sort=#{sort}", headers: @headers).body)
  end
end
