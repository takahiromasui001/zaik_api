# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::SessionsController, type: :request do
  describe 'POST /api/v1/login' do
    context 'ユーザ名 & パスワードが正しい場合' do
      it '200 OKを返すこと' do
        create(:user, name: 'login_user', password: 'login_user_password', password_confirmation: 'login_user_password')
        post api_v1_login_path, params: { name: 'login_user', password: 'login_user_password' }
        expect(response.status).to eq 200
      end

      it 'ログイン成功を表すメッセージを返すこと' do
        create(:user, name: 'login_user', password: 'login_user_password', password_confirmation: 'login_user_password')
        post api_v1_login_path, params: { name: 'login_user', password: 'login_user_password' }
        expect(JSON.parse(response.body)['message']).to eq 'login succeed'
      end

      it 'ログイン確認が成功すること' do
        create(:user, name: 'login_user', password: 'login_user_password', password_confirmation: 'login_user_password')
        post api_v1_login_path, params: { name: 'login_user', password: 'login_user_password' }

        get api_v1_logged_in_path
        expect(response.status).to eq 200
        expect(JSON.parse(response.body)['message']).to eq 'logged in'
      end
    end

    context 'ユーザ名が誤っている場合' do
      it '401 Unauthorizedを返すこと' do
        create(:user, name: 'login_user', password: 'login_user_password', password_confirmation: 'login_user_password')
        post api_v1_login_path, params: { name: 'login_user_false', password: 'login_user_password' }
        expect(response.status).to eq 401
      end

      it 'エラーメッセージを返すこと' do
        create(:user, name: 'login_user', password: 'login_user_password', password_confirmation: 'login_user_password')
        post api_v1_login_path, params: { name: 'login_user_false', password: 'login_user_password' }
        expect(JSON.parse(response.body)['message']).to eq 'ユーザ名またはパスワードに誤りがあります。'
      end

      it 'ログイン確認が失敗すること' do
        create(:user, name: 'login_user', password: 'login_user_password', password_confirmation: 'login_user_password')
        post api_v1_login_path, params: { name: 'login_user_false', password: 'login_user_password' }

        get api_v1_logged_in_path
        expect(response.status).to eq 401
      end
    end

    context 'パスワードが誤っている場合' do
      it '401 Unauthorizedを返すこと' do
        create(:user, name: 'login_user', password: 'login_user_password', password_confirmation: 'login_user_password')
        post api_v1_login_path, params: { name: 'login_user', password: 'login_user_password_false' }
        expect(response.status).to eq 401
      end

      it 'エラーメッセージを返すこと' do
        create(:user, name: 'login_user', password: 'login_user_password', password_confirmation: 'login_user_password')
        post api_v1_login_path, params: { name: 'login_user', password: 'login_user_password_false' }
        expect(JSON.parse(response.body)['message']).to eq 'ユーザ名またはパスワードに誤りがあります。'
      end

      it 'ログイン確認に失敗すること' do
        create(:user, name: 'login_user', password: 'login_user_password', password_confirmation: 'login_user_password')
        post api_v1_login_path, params: { name: 'login_user', password: 'login_user_password_false' }

        get api_v1_logged_in_path
        expect(response.status).to eq 401
      end
    end
  end

  describe 'DELETE /api/v1/logout' do
    context '未ログインの場合' do
      it '401 Unauthorizedを返すこと' do
        delete api_v1_logout_path
        expect(response.status).to eq 401
      end

      it 'エラーメッセージを返すこと' do
        delete api_v1_logout_path
        expect(JSON.parse(response.body)['message']).to eq 'unauthorized'
      end
    end

    context 'ログイン済みの場合' do
      it '200 OKを返すこと' do
        _, token = login
        delete api_v1_logout_path, headers: { 'x-csrf-token': token }
        expect(response.status).to eq 200
      end

      it 'ログアウト成功のメッセージを返すこと' do
        _, token = login
        delete api_v1_logout_path, headers: { 'x-csrf-token': token }
        expect(JSON.parse(response.body)['message']).to eq 'logout succeed'
      end

      it 'ログイン確認に失敗すること' do
        _, token = login
        expect(response.status).to eq 200

        delete api_v1_logout_path, headers: { 'x-csrf-token': token }

        get api_v1_logged_in_path
        expect(response.status).to eq 401
      end
    end

    context 'リクエストにcsrf tokenが存在しない場合' do
      it 'ActionController::InvalidAuthenticityToken の例外が発生すること' do
        login
        expect { delete api_v1_logout_path }.to raise_error(ActionController::InvalidAuthenticityToken)
      end
    end
  end

  describe 'GET /api/v1/logged_in' do
    context '未ログインの場合' do
      it '401 Unauthorizedを返すこと' do
        get api_v1_logged_in_path
        expect(response.status).to eq 401
      end

      it 'エラーメッセージを返すこと' do
        get api_v1_logged_in_path
        expect(JSON.parse(response.body)['message']).to eq 'unauthorized'
      end
    end

    context 'ログイン済みの場合' do
      it '200 OKを返すこと' do
        login
        get api_v1_logged_in_path
        expect(response.status).to eq 200
      end

      it '正しいレスポンスを返すこと' do
        login
        get api_v1_logged_in_path
        expect(JSON.parse(response.body)['message']).to eq 'logged in'
      end
    end
  end
end
