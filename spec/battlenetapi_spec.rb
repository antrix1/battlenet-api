require 'spec_helper'

describe Battlenet::Client do
  context "when special characters are in realm names" do
    before do
      Battlenet.configure do |config|
        config.access_token = ENV['BATTLENET_ACCESS_TOKEN']
        config.region  = :eu
      end
    end
  end
end
