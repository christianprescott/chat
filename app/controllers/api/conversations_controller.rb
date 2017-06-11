class Api::ConversationsController < ApiController
  def index
    render json: current_user.conversations, include: [:users]
  end

  def create
    # The need to create conversation before creating messages is a little
    # awkward, even if the client hides it in UX. I don't mind bending the
    # "rules" of REST to make things transactional. Another approach might
    # be shallow routes on MessagesController to find_or_create the
    # conversation.

    to_name = params[:to]
    raise ActionController::BadRequest, 'to is required' if to_name.blank?
    to_user = User.find_by(name: to_name)
    raise ActionController::BadRequest, 'recipient must exist' if to_user.blank?
    raise ActionController::BadRequest, 'recipient must not be sender' if to_user == current_user

    conversation = Conversation.create!
    conversation.participations.create!(user: to_user)
    conversation.participations.create!(user: current_user)
    render json: conversation
  end
end
