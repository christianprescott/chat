class Api::MessagesController < ApiController
  def index
    render json: nested_scope.order(created_at: :desc)
  end

  def create
    message = nested_scope.create!(message_params.merge(user: current_user))
    render json: message
  end

  private

  def nested_scope
    conversation = current_user.conversations.find(params[:conversation_id])
    conversation.messages
  end

  def message_params
    params.require(:message).permit(:body)
  end
end
