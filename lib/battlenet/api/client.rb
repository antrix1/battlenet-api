require 'battlenet/api/version'
require 'battlenet/api/api_response'
require 'battlenet/api/exceptions'
require 'httparty'
require 'addressable/uri'

module Battlenet
  class Client
    attr_accessor *Configuration::OPTIONS_KEYS

    def initialize(options={})
      options = Battlenet.options.merge(options)

      Configuration::OPTIONS_KEYS.each do |key|
        send("#{key}=", options[key])
      end
    end

    def base_uri
      "https://#{domain}#{endpoint}"
    end

    def domain
      domain = case @region
      when :us
        'us.api.blizzard.com'
      when :eu
        'eu.api.blizzard.com'
      when :kr
        'kr.api.blizzard.com'
      when :tw
        'tw.api.blizzard.com'
      when :cn
        'gateway.battlenet.com.cn'
      else
        raise "Invalid region: #{region.to_s}"
      end
    end

    def endpoint
      raise "Invalid Game Endpoint" if @endpoint == nil
      @endpoint
    end

    def get(path, params = {})
      byebug
      make_request :get, path, params
    end

    def make_request(verb, path, params = {})
      options = {}
      headers = {}

      options[:headers] = headers unless headers.empty?
      options[:query]   = params unless params.empty?

      if @access_token
        options[:query] ||= {}
        options[:query].merge!({ access_token: @access_token })
      end

      encoded_path = Addressable::URI.encode(path)

      response = HTTParty.send(verb, "#{base_uri}#{encoded_path}" , options)

      handle_response(response)
    end

    private

    def handle_response(response)
      headers     = response.headers
      qps_alloted = headers["x-plan-qps-allotted"].to_i
      qps_current = headers["x-plan-qps-current"].to_i
      qph_alloted = headers["x-plan-quota-allotted"].to_i
      qph_current = headers["x-plan-quota-current"].to_i
      limit_reset = DateTime.parse(headers["x-plan-quota-reset"])

      if qps_current == qps_alloted
        raise Battlenet::RateLimited.new('Rate limit hit for the second', qps_alloted, qps_current, qph_alloted, qph_current)
      elsif qph_alloted == qph_current
        raise Battlenet::RateLimited.new('Rate limit hit for the hour', qps_alloted, qps_current, qph_alloted, qph_current, limit_reset)
      else
        response
      end
    end
  end
end
