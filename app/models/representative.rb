# frozen_string_literal: true

class Representative < ApplicationRecord
    has_many :news_items, dependent: :delete_all

    def self.civic_api_to_representative_params(rep_info)
        reps = []

        rep_info.officials.each_with_index do |official, index|
            rep = create_representatives(official, rep_info, index)
            reps.push(rep)
        end

        reps
    end

    def self.create_representatives(official, rep_info, index)
        party_temp = official.party || ''
        photo_url_temp = official.photo_url || ''
        address_temp = extract_address(official)
        title_temp, ocdid_temp = extract_title_and_ocdid(rep_info, index)

        Representative.create!({ name: official.name, ocdid: ocdid_temp,
                title: title_temp, address: address_temp, party: party_temp, photo_url: photo_url_temp })
    end

    def self.extract_address(official)
        address_temp = ''

        official.address&.each do |addr|
            address_temp += '\n' if address_temp != ''
            addr_temp = addr.line1 + ', ' + addr.city + ', ' + addr.state + ', ' + addr.zip
            address_temp += addr_temp
        end
        address_temp
    end

    def self.extract_title_and_ocdid(rep_info, index)
        title_temp = ''
        ocdid_temp = ''

        rep_info.offices.each do |office|
            if office.official_indices.include? index
                title_temp = office.name
                ocdid_temp = office.division_id
            end
        end
        [title_temp, ocdid_temp]
    end

    private_class_method :create_representatives
    private_class_method :extract_address
    private_class_method :extract_title_and_ocdid
end
