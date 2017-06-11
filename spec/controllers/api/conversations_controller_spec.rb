require "rails_helper"

RSpec.describe Api::ConversationsController, type: :controller do
  describe '#index' do
    it_behaves_like 'user authenticated resource' do
      def make_request; get :index; end
    end

    it 'responds with conversations belonging to the user' do
      my_chat = create(:participation, user: current_user).conversation
      other_chat = create :conversation
      get :index
      expect(json.map { |c| c['id'] }).to include my_chat.id
      expect(json.map { |c| c['id'] }).not_to include other_chat.id
    end
  end

  describe '#create' do
    let!(:recipient) { create :user }

    it_behaves_like 'user authenticated resource' do
      def make_request; post :create, params: { conversation: { to: recipient.name } }; end
    end

    it 'requires to param' do
      post :create
      expect(response).to have_http_status :bad_request
    end

    it 'requires non-sender to param' do
      post :create, params: { conversation: { to: current_user.name } }
      expect(response).to have_http_status :bad_request
    end

    it 'requires existing to user' do
      post :create, params: { conversation: { to: 'four_oh_four' } }
      expect(response).to have_http_status :bad_request
    end

    it 'does not create a conversation when one exists for set of users' do
      # Not sure if this validation is necessary. It could be like email or
      # message board, where multiple conversations can exist with same users.
      pending 'decision by product management'
      chat = create :conversation
      create :participation, user: current_user, conversation: chat
      create :participation, user: recipient, conversation: chat
      expect { post :create, params: { conversation: { to: recipient.name } } }
        .not_to change { Conversation.count }
      expect(response).to have_http_status :bad_request
    end

    it 'creates a conversation between two users' do
      post :create, params: { conversation: { to: recipient.name } }
      expect(Conversation.find(json['id']).participations.count).to eq 2
    end
  end
end
