class ApiController < ApplicationController
  before_action :require_user

  class NotAuthorizedError < StandardError; end

  rescue_from NotAuthorizedError do |e|
    render json: { error: e.message }, status: :unauthorized
  end

  def current_user
    User.find_or_create_by!(name: params[:username])
  end

  private

  def require_user
    # TODO: authorization
    raise NotAuthorizedError, 'username is required' unless params[:username].present?
  end
end
