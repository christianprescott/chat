class Api::MessagesController < ApiController
  def index
    conversation = current_user.conversations.find(params[:conversation_id])
    render json: conversation.messages.order(created_at: :desc)
  end
end
