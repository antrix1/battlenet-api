module Battlenet
  module WOW
    class Conduit < Battlenet::APIResponse
      def initialize(options = {})
        @conduit        = options.delete(:id)
        @endpoint       = "/"
        @region         = options[:client].region

        super(options)
      end

      def details(options = {})
        get_data("/data/wow/covenant/conduit/#{@conduit}", options.merge(namespace: "static-#{@region}"))
      end
    end
  end
end
