# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SearchController, type: :controller do
    describe '#search' do
        before :each do
            stub_request(:get, /.*civicinfo*/).to_return(
                headers: [['Content-Type', 'application/json; charset=UTF-8']],
                body:    File.read(File.join('google_civic_api.json'))
            )
        end

        it 'shows the representatives' do
            get :search, params: { address: 'CA' }
            expect(!assigns(:representatives).empty?)
        end
    end
end
