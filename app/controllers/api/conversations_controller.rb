class Api::ConversationsController < ApiController
  def index
    render json: current_user.conversations
  end
end
