module Battlenet
  module WOW
    class PVPLeaderboard < Battlenet::APIResponse
      def initialize(options={})
        @bracket  = options.delete(:bracket)
        @season   = options.delete(:season)
        @endpoint = "/data/wow/pvp-season/#{@season}/pvp-leaderboard/#{@bracket}"
        @region   = options[:client].region

        super(options)
      end

      def details(options = {})
        get_data(@endpoint, options.merge(namespace: "dynamic-#{@region}"))
      end
    end
  end
end
