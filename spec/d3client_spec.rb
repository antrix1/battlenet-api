require 'spec_helper'

describe Battlenet::D3Client do
  before(:all) do
    Battlenet.configure do |config|
      config.access_token = ENV['BATTLENET_ACCESS_TOKEN']
      config.region  = :us
    end
  end

  it "should pass the api key to the d3 client" do
    c = Battlenet.D3Client
    expect(c.access_token).to eq(ENV['BATTLENET_ACCESS_TOKEN'])
  end

  it { should respond_to(:data) }
  it { should respond_to(:profile) }

end
