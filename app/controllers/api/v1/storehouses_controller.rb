# frozen_string_literal: true

module Api
  module V1
    class StorehousesController < ApplicationController
      def index
        storehouses = Storehouse.all
        result = storehouses.map do |storehouse|
          {
            id: storehouse.id,
            name: storehouse.name
          }
        end
        render json: result
      end
    end
  end
end
