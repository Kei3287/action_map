# frozen_string_literal: true

require 'rails_helper'
require 'ostruct'

civic_result = OpenStruct.new(
    {
        officials: [
            OpenStruct.new({
                               address:   [
                                   OpenStruct.new({
                                                      city:  'Washington',
                                                      state: 'DC',
                                                      zip:   '20500',
                                                      line1: '1600 Pennsylvania Avenue Northwest'
                                                  })
                               ],
                               name:      'Donald J. Trump',
                               party:     'Republican Party',
                               photo_url: 'https://www.whitehouse.gov/sites/whitehouse.gov/files/images/45/PE%20Color.jpg'
                           }),
            OpenStruct.new({
                               address:   [
                                   OpenStruct.new({
                                                      city:  'Berkeley',
                                                      state: 'CA',
                                                      zip:   '00000',
                                                      line1: 'test address'
                                                  })
                               ],
                               name:      'test',
                               party:     'Democratic Party',
                               photo_url: 'test url'
                           })
        ],
        offices:   [
            OpenStruct.new({
                               division_id:      'ocd-division/country:us',
                               official_indices: [0],
                               name:             'President of the United States'
                           }),
            OpenStruct.new({
                               division_id:      'test division',
                               official_indices: [1],
                               name:             'test'
                           })
        ]
    }
)

civic_result2 = OpenStruct.new(
    {
        officials: [
            OpenStruct.new({ name: 'Donald J. Trump' })
        ],
        offices:   [
            OpenStruct.new({
                               division_id:      'ocd-division/country:us',
                               official_indices: [0],
                               name:             'President of the United States'
                           })
        ]
    }
)

describe 'Representatives' do
    describe RepresentativesController, type: :controller do
        before :each do
            @representatives = [
                { name: 'rep1', ocdid: '123', title: 'AAA', address: 'Berkeley, CA',
                  party: 'Democrats', photo_url: 'a' },
                { name: 'rep2', ocdid: '123', title: 'AAA', address: 'Berkeley, CA',
                  party: 'Democrats', photo_url: 'a' },
                { name: 'rep3', ocdid: '123', title: 'AAA', address: 'Berkeley, CA',
                  party: 'Democrats', photo_url: 'a' }
            ]
            @representatives.each do |r|
                Representative.create!(r)
            end
        end

        it 'show the representative with all the attributes' do
            rep = Representative.find_by(name: 'rep1')
            get :show, params: { id: rep.id }
            assigns(:representative).each do |r|
                expect(r[:name]).to eq rep.name
                expect(r[:ocdid]).to eq rep.ocdid
                expect(r[:title]).to eq rep.title
                expect(r[:address]).to eq rep.address
                expect(r[:party]).to eq rep.party
                expect(r[:photo_url]).to eq rep.photo_url
            end
        end

        it 'show all representatives' do
            get :index
            expect(assigns(:representatives).length).to eq @representatives.length
        end
    end

    describe Representative, type: :model do
        before :each do
            @representatives = [
                { name: 'rep1', ocdid: '123', title: 'AAA', address: 'Berkeley, CA',
                  party: 'Democrats', photo_url: 'a' },
                { name: 'rep2', ocdid: '123', title: 'AAA', address: 'Berkeley, CA',
                  party: 'Democrats', photo_url: 'a' },
                { name: 'rep3', ocdid: '123', title: 'AAA', address: 'Berkeley, CA',
                  party: 'Democrats', photo_url: 'a' }
            ]
            @representatives.each do |r|
                Representative.create!(r)
            end
        end

        def extract_address(address)
            address_temp = ''

            address.each do |addr|
                address_temp += '\n' if address_temp != ''
                addr_temp = addr.line1 + ', ' + addr.city + ', ' + addr.state + ', ' + addr.zip
                address_temp += addr_temp
            end
            address_temp
        end

        it 'create the representatives' do
            reps = Representative.civic_api_to_representative_params(civic_result)
            expect(!reps.empty?)
        end

        it 'create the representatives with the correct attributes' do
            reps = Representative.civic_api_to_representative_params(civic_result)
            reps.each_with_index do |r, index|
                expect(r.name).to eq civic_result.officials[index].name
                expect(r.address).to eq extract_address(civic_result.officials[index].address)
                expect(r.party).to eq civic_result.officials[index].party
                expect(r.photo_url).to eq civic_result.officials[index].photo_url
                expect(r.ocdid).to eq civic_result.offices[index].division_id
                expect(r.title).to eq civic_result.offices[index].name
            end
        end

        it 'create the representatives without address, party, and photo_url' do
            reps = Representative.civic_api_to_representative_params(civic_result2)
            reps.each_with_index do |r, index|
                expect(r.name).to eq civic_result.officials[index].name
                expect(r.ocdid).to eq civic_result.offices[index].division_id
                expect(r.title).to eq civic_result.offices[index].name
            end
        end
    end
end
