# frozen_string_literal: true

require_relative 'spec_helper'
require_relative 'helpers/vcr_helper'
require_relative 'helpers/database_helper'
require 'securerandom'


describe 'Integration Tests of AMADEUS API and Database' do
  VcrHelper.setup_vcr

  before do
    # Check request body as token and secret are not included in headers
    VcrHelper.configure_vcr_for_amadeus
  end

  after do
    VcrHelper.eject_vcr
  end

  describe 'Retrieve Currency By Currency Code' do
    
    it 'HAPPY: there should be 4 currencies: TWD USD EUR' do
      reposit = ComfyWings::Repository::For.klass(ComfyWings::Entity::Currency)
      currencies = reposit.all
      _(currencies.size).must_equal(4)
    end

    it 'HAPPY: should be able to save tripQuery from amadeus to TripQuery table in database' do
      trip_query = ComfyWings::Amadeus::TripQueryMapper.new(AMADEUS_KEY, AMADEUS_SECRET)
        .search('TPE', 'MAD', '2022-11-21', '2022-11-28')

      query_rebuilt = ComfyWings::Repository::For.entity(trip_query).create(trip_query)
      

      _(query_rebuilt.origin).must_equal(trip_query[0].origin)
      _(query_rebuilt.destination).must_equal(trip_query[0].destination)
    end
  end
end
