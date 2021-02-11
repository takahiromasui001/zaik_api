# frozen_string_literal: true

class ApplicationController < ActionController::API
  include ActionController::RequestForgeryProtection
  before_action :login_check
  protect_from_forgery with: :exception
  rescue_from ActiveRecord::RecordNotFound, with: :error404_record_not_found

  def login_check
    if current_user.blank?
      render json: { message: 'unauthorized' }, status: 401
    end
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def set_csrf_token_header
    response.set_header('X-CSRF-Token', form_authenticity_token)
  end

  def error404_record_not_found
    render json: { message: 'record not found' }, status: 404
  end

  def record_invalid_error(stock)
    render json: { message: stock.errors.full_messages }, status: :unprocessable_entity
  end
end
