# frozen_string_literal: true

module Api
  module V1
    class StocksController < ApplicationController
      before_action :set_stock, only: [:show, :update, :destroy]
      def index
        stocks = Stock.with_attached_file.where('name like ?',  "%#{params[:search]}%")
        result = stocks.map do |stock|
          {
            id: stock.id,
            name: stock.name,
            file: stock.file.present? ? Base64.encode64(stock.file.first.download) : nil
          }
        end
        render json: result
      end

      def show
        render json: stock_response(@stock)
      end

      def create
        snake_stock_params = stock_params.transform_keys { |k| k.underscore }
        stock = Stock.new(snake_stock_params)

        if stock.save
          render json: stock_response(stock)
        else
          record_invalid_error(stock)
        end
      end

      def update
        snake_stock_params = stock_params.transform_keys { |k| k.underscore }
        if @stock.update(snake_stock_params)
          render json: stock_response(@stock)
        else
          record_invalid_error(@stock)
        end
      end

      def destroy
        @stock.destroy
        render json: @stock
      end

      private
        def set_stock
          @stock = Stock.find(params[:id])
        end

        def stock_params
          params.permit(:name, :storehouse_id, :id, :file, :colorNumber, :manufacturingDate, :quantity, :condition, :storehouse, :stock)
        end

        def stock_response(stock)
          {
            id: stock.id,
            name: stock.name,
            colorNumber: stock.color_number,
            manufacturingDate: stock.manufacturing_date,
            quantity: stock.quantity,
            condition: stock.condition,
            storehouse: {
              id: stock.storehouse.id,
              name: stock.storehouse.name
            },
            file: stock.file.present? ? Base64.encode64(stock.file.first.download) : nil
          }
        end
    end
  end
end
