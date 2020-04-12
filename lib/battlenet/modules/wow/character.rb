module Battlenet
  module WOW
    class Character < Battlenet::APIResponse
      def initialize(options={})
        @realm          = options.delete(:realm)
        @character_name = options.delete(:character_name)
        @endpoint       = "/profile/wow/character/#{@realm}/#{@character_name}"

        super(options)
      end

      def profile
        get_data(@endpoint)
      end

      def achievements
        get_data("#{@endpoint}/achievements")
      end

      def appearance
        get_data("#{@endpoint}/appearance")
      end

      def hunter_pets
        get_data("#{@endpoint}/hunter-pets")
      end

      def pets
        get_data("#{@endpoint}/collections/pets")
      end

      def items
        get_data("#{@endpoint}/equipment")
      end

      def mounts
        get_data("#{@endpoint}/collections/mounts")
      end

      def pet_slots
        get_data("#{@endpoint}/collections/pets")
      end

      def professions
        get_data("#{@endpoint}/professions")
      end

      def progression(encounter = 'encounters')
        get_data("#{@endpoint}/#{encounter}")
      end

      def pvp_summary
        get_data("#{@endpoint}/pvp-summary")
      end

      def pvp_bracket(bracket = '3v3')
        get_data("#{@endpoint}/pvp-bracket/#{bracket}")
      end

      def quests
        get_data("#{@endpoint}/quests")
      end

      def completed_quests
        get_data("#{@endpoint}/quests/completed")
      end

      def reputation
        get_data("#{@endpoint}/reputations")
      end

      def statistics
        get_data("#{@endpoint}/achievements/statistics")
      end

      def stats
        get_data("#{@endpoint}/statistics")
      end

      def talents
        get_data("#{@endpoint}/specializations")
      end

      def titles
        get_data("#{@endpoint}/titles")
      end

      def media
        get_data("#{@endpoint}/character-media")
      end
    end
  end
end
