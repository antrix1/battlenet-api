require 'spec_helper'

describe Battlenet::WOWClient do
  before(:all) do
    Battlenet.configure do |config|
      config.access_token = ENV['BATTLENET_ACCESS_TOKEN']
      config.region  = :us
    end
  end

  it "should pass the api key to the wow client" do
    c = Battlenet.WOWClient
    expect(c.access_token).to eq(ENV['BATTLENET_ACCESS_TOKEN'])
  end

  it { should respond_to(:character) }
  it { should respond_to(:mount) }
  it { should respond_to(:pet) }
  it { should respond_to(:challenge) }
  it { should respond_to(:guild) }
  it { should respond_to(:item) }
  it { should respond_to(:item_set) }
  it { should respond_to(:achievement) }
  it { should respond_to(:auction) }
  it { should respond_to(:pvp_leaderboard) }
  it { should respond_to(:quest) }
  it { should respond_to(:realm) }
  it { should respond_to(:recipe) }
  it { should respond_to(:spell) }
  it { should respond_to(:data) }

end
