module Battlenet
  module WOW
    class Item < Battlenet::APIResponse
      def initialize(options = {})
        @item          = options.delete(:item)
        @endpoint       = "/"
        @region         = options[:client].region

        super(options)
      end

      def details(options = {})
        get_data("/data/wow/item/#{@item}", options.merge(namespace: "static-#{@region}"))
      end

      def media(options = {})
        get_data("/data/wow/media/item/#{@item}", options.merge(namespace: "static-#{@region}"))
      end
    end
  end
end
