# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::StorehousesController, type: :request do
  describe 'GET /api/v1/storehouses' do
    context '未ログインの場合' do
      it '401 Unauthorizedを返すこと' do
        get api_v1_storehouses_path
        expect(response.status).to eq 401
      end

      it 'エラーメッセージを返すこと' do
        get api_v1_storehouses_path
        expect(JSON.parse(response.body)['message']).to eq 'unauthorized'
      end
    end

    context 'ログインしている場合' do
      it '200 OKを返すこと' do
        login
        names = ['storehouse0', 'storehouse1', 'storehouse2']
        3.times { |i| create(:storehouse, name: names[i]) }

        get api_v1_storehouses_path
        expect(response.status).to eq 200
      end

      it '正しいレスポンスを返すこと' do
        login
        names = ['storehouse0', 'storehouse1', 'storehouse2']
        3.times { |i| create(:storehouse, name: names[i]) }

        get api_v1_storehouses_path
        actual = JSON.parse(response.body)

        actual.each_with_index { |storehouse, i| expect(storehouse['name']).to eq names[i] }
      end
    end
  end
end
