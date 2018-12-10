require 'spec_helper'

describe Battlenet::WOW::Pet do

  context "when looking up a species" do
    before do
      Battlenet.configure do |config|
        config.access_token = ENV['BATTLENET_ACCESS_TOKEN']
        config.region  = :us
      end
      @wow_client = Battlenet.WOWClient
    end
  end

  it { should respond_to(:master_list) }
  it { should respond_to(:ability) }
  it { should respond_to(:species) }
  it { should respond_to(:stats) }

end
