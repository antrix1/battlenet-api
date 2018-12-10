module Battlenet
  module Configuration

    OPTIONS_KEYS = [
      :access_token,
      :region,
      :locale,
      :endpoint
    ].freeze

    DEFAULT_ACCESS_TOKEN  = nil
    DEFAULT_ENDPOINT = nil
    DEFAULT_REGION   = :us
    DEFAULT_LOCALE   = :en_US

    attr_accessor *OPTIONS_KEYS

    def configure
      yield self
    end

    def options
      OPTIONS_KEYS.inject({}) do |option, key|
        option.merge!(key => send(key))
      end
    end

  end
end
