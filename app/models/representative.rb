# frozen_string_literal: true

class Representative < ApplicationRecord
    has_many :news_items, dependent: :delete_all

    def self.civic_api_to_representative_params(rep_info)
        reps = []

        rep_info.officials.each_with_index do |official, index|
            ocdid_temp = ''
            title_temp = ''
            party_temp = ''
            photo_url_temp = ''
            address_temp = ''

            if official.address.presence
                official.address.each do |addr|
                    address_temp += '\n' if address_temp != ''
                    addr_temp = addr.line1 + ', ' + addr.city + ', ' + addr.state + ', ' + addr.zip
                    address_temp += addr_temp
                end
            end
            party_temp = official.party if official.party.presence
            photo_url_temp = official.photo_url if official.photo_url.presence

            rep_info.offices.each do |office|
                if office.official_indices.include? index
                    title_temp = office.name
                    ocdid_temp = office.division_id
                end
            end

            rep = Representative.create!({ name: official.name, ocdid: ocdid_temp,
                title: title_temp, address: address_temp, party: party_temp, photo_url: photo_url_temp })
            reps.push(rep)
        end

        reps
    end
end
