class Api::MessagesController < ApiController
  def index
    participation.touch(:read_at)
    render json: nested_scope.order(created_at: :desc)
  end

  def create
    message = nested_scope.create!(message_params.merge(user: current_user))
    conversation.touch
    participation.touch(:read_at)
    render json: message
  end

  private

  def participation
    @participation ||= current_user.participations.find_by!(conversation_id: params[:conversation_id])
  end

  def conversation
    @conversation ||= participation.conversation
  end

  def nested_scope
    conversation.messages
  end

  def message_params
    params.require(:message).permit(:body)
  end
end
