module Battlenet
  module WOW
    class TechTalent < Battlenet::APIResponse
      def initialize(options = {})
        @talent         = options.delete(:id)
        @endpoint       = "/"
        @region         = options[:client].region

        super(options)
      end

      def details(options = {})
        get_data("/data/wow/tech-talent/#{@talent}", options.merge(namespace: "static-#{@region}"))
      end
    end
  end
end
