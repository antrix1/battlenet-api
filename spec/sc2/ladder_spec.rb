require 'spec_helper'

describe Battlenet::SC2::Ladder do

  context "when looking up ladder" do
    before do
      Battlenet.configure do |config|
        config.api_key = ENV['BATTLENET_API_KEY']
        config.region  = :us
      end
      @sc2_client = Battlenet.SC2Client
    end

  end

  it { should respond_to(:details) }

end
