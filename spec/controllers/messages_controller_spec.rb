require 'rails_helper'

RSpec.describe Api::MessagesController, type: :controller do
  let(:conversation) { create :conversation }

  describe '#index' do
    it 'responds 404 if the user is not a participant in conversation' do
      get :index, params: { conversation_id: conversation.id }
      expect(response).to have_http_status :not_found
    end

    it 'responds with messages in conversation' do
      create :participation, user: current_user, conversation: conversation
      my_message = create :message, user: current_user, conversation: conversation
      other_message = create :message, user: current_user
      get :index, params: { conversation_id: conversation.id }
      expect(json.map { |c| c['id'] }).to include my_message.id
      expect(json.map { |c| c['id'] }).not_to include other_message.id
    end

    it 'orders messages by most recent' do
      create :participation, user: current_user, conversation: conversation
      first = create :message, user: current_user, conversation: conversation, created_at: 2.hours.ago
      third = create :message, user: current_user, conversation: conversation
      second = create :message, user: current_user, conversation: conversation, created_at: 1.hour.ago
      get :index, params: { conversation_id: conversation.id }
      expect(json.map { |c| c['id'] }).to eq [third.id, second.id, first.id]
    end
  end
end
