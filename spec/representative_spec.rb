# frozen_string_literal: true

require 'rails_helper'

describe 'Representatives' do
    describe RepresentativesController, type: :controller do
        before :each do
            representatives = [
                { name: 'rep1', ocdid: '123', title: 'AAA', address: 'Berkeley, CA', party: 'Democrats', photo_url: 'a' }
            ]
            representatives.each do |r|
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
    end
end
