# frozen_string_literal: true

module LoginHelper
  def login
    user = create(:user, name: 'login_user', password: 'login_user_password', password_confirmation: 'login_user_password')
    post api_v1_login_path, params: { name: 'login_user', password: 'login_user_password' }
    token = response.headers['x-csrf-token']
    [user, token]
  end
end
