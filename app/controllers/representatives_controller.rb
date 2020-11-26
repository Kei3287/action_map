# frozen_string_literal: true

class RepresentativesController < ApplicationController
    def index
        @representatives = Representative.all
    end

    def show
        @representative = Representative.where(id: params[:id])
    end
end
