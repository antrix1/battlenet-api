module Battlenet
  module WOW
    class PVPLeaderboard < Battlenet::APIResponse
      def initialize(options={})
        @bracket        = options.delete(:bracket)
        @season         = options.delete(:season)
        @endpoint       = "/data/wow/pvp-season/#{@season}/pvp-leaderboard/#{@bracket}"

        super(options)
      end

      def details
        get_data(@endpoint)
      end
    end
  end
end
