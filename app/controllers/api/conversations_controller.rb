class Api::ConversationsController < ApiController
  def index
    current_user
    render json: []
  end
end
