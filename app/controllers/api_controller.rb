class ApiController < ApplicationController
  before_action :require_user

  class NotAuthorizedError < StandardError; end

  rescue_from NotAuthorizedError do |e|
    render json: { error: e.message }, status: :unauthorized
  end

  private

  def require_user
    raise NotAuthorizedError, 'user_id is required' unless params[:user_id].present?
  end
end
