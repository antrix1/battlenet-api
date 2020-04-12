module Battlenet
  module WOW
    class Spell < Battlenet::APIResponse
      def initialize(options = {})
        @spell          = options.delete(:spell)
        @endpoint       = "/"
        @region         = options[:client].region

        super(options)
      end

      def details(options = {})
        get_data("/data/wow/spell/#{@spell}", options.merge(namespace: "static-#{@region}"))
      end

      def media(options = {})
        get_data("/data/wow/media/spell/#{@spell}", options.merge(namespace: "static-#{@region}"))
      end
    end
  end
end
