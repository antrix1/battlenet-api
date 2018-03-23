require 'spec_helper'

describe Battlenet::Client do
  it 'is expected not to override API url when creating multiple clients' do
    eu_client = Battlenet::Client.new(api_key: 'api_key', region: :eu, endpoint: '/wow')
    expect(eu_client.base_uri).to eq 'https://eu.api.battle.net/wow'

    us_client = Battlenet::Client.new(api_key: 'api_key', region: :us, endpoint: '/wow')
    expect(us_client.base_uri).to eq 'https://us.api.battle.net/wow'

    expect(eu_client.base_uri).to eq 'https://eu.api.battle.net/wow'
  end

  context 'ratelimiting' do
    let(:client) { Battlenet::WOWClient.new(api_key: 'api_key', region: :eu) }
    let(:default_headers) {
      {
        "x-plan-qps-allotted" => 100,
        "x-plan-qps-current" => 0,
        "x-plan-quota-allotted" => 36000,
        "x-plan-quota-current" => 0,
        "x-plan-quota-reset" => "2018-03-22 20:00:00 UTC"
      }
    }

    before(:each) do
      stub_request(:get, /api.battle.net/).
        with(headers: {'Accept' => '*/*', 'User-Agent' => 'Ruby'}).
        to_return(status: 200, body: "Stubbed Response", headers: headers)
    end

    context 'when current quota is the same as alloted' do
      let(:headers) { default_headers.merge!("x-plan-quota-current" => 36000) }

      it 'is expected to raise error when hourly limit is hit' do
        expect {
          client.character(realm: 'Ravencrest', character_name: 'Antrix').pvp
        }.to raise_exception(Battlenet::RateLimited) do |e|
          expect(e.message).to eq 'Rate limit hit for the hour'
          expect(e.qps_alloted).to eq 100
          expect(e.qps_current).to eq 0
          expect(e.qph_alloted).to eq 36000
          expect(e.qph_current).to eq 36000
          expect(e.limit_reset).to eq DateTime.parse("2018-03-22 20:00:00 UTC")
        end
      end
    end

    context 'when current quota is less than alloted' do
      let(:headers) { default_headers.merge!("x-plan-quota-current" => 35000) }

      it 'is expected not to raise error when there are available requests' do
        expect {
          client.character(realm: 'Ravencrest', character_name: 'Antrix').pvp
        }.not_to raise_exception(Battlenet::RateLimited)
      end
    end

    context 'when quota for the second is the same as alloted' do
      let(:headers) { default_headers.merge!("x-plan-qps-current" => 100) }

      it 'is expected to raise error when limit for the second is hit' do
        expect {
          client.character(realm: 'Ravencrest', character_name: 'Antrix').pvp
        }.to raise_exception(Battlenet::RateLimited) do |e|
          expect(e.message).to eq 'Rate limit hit for the second'
          expect(e.qps_alloted).to eq 100
          expect(e.qps_current).to eq 100
          expect(e.qph_alloted).to eq 36000
          expect(e.qph_current).to eq 0
          expect(e.limit_reset).to eq nil
        end
      end
    end

    context 'when current second quota is less than alloted' do
      let(:headers) { default_headers.merge!("x-plan-qps-current" => 90) }

      it 'is expected not to raise error when there are available requests' do
        expect {
          client.character(realm: 'Ravencrest', character_name: 'Antrix').pvp
        }.not_to raise_exception(Battlenet::RateLimited)
      end
    end
  end

  # it "should translate foreign characters for URLS (whispä)" do
  #   character = @client.character({realm: 'sargeras', character_name: 'Silverwinter'})
  # end
  #
  # it "should translate spaces accurately for URLS (emerald dream)" do
  #   character = @client.character({:realm => 'emerald dream', :character_name => 'pftpft'})
  # end
end
