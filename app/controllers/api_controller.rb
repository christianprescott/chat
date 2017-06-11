class ApiController < ApplicationController
  before_action :require_user

  class NotAuthorizedError < StandardError; end

  rescue_from NotAuthorizedError do |e|
    render json: { error: e.message }, status: :unauthorized
  end

  rescue_from ActionController::ParameterMissing, ActionController::BadRequest do |e|
    render json: { error: e.message }, status: :bad_request
  end

  def current_user
    User.find_or_create_by!(name: current_username)
  end

  private

  def current_username
    params[:username]
  end

  def require_user
    # TODO: authorization
    raise NotAuthorizedError, 'username is required' unless current_username.present?
  end
end
