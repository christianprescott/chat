require 'rails_helper'

RSpec.describe Api::MessagesController, type: :controller do
  let_once(:conversation) { create :conversation, created_at: 3.hours.ago }

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

    it 'updates participant read_at' do
      participation = create :participation, user: current_user, conversation: conversation, read_at: 30.minutes.ago
      # Time#round to match precision lost in roundtrip to db
      Timecop.freeze(Time.zone.now.round) do
        get :index, params: { conversation_id: conversation.id }
        expect(participation.reload.read_at).to eq Time.zone.now.round
      end
    end
  end

  describe '#create' do
    let_once(:message_params) do
      {
        conversation_id: conversation.id,
        message: { body: 'shiny new message' }
      }
    end

    it 'responds 404 if the user is not a participant in conversation' do
      post :create, params: message_params
      expect(response).to have_http_status :not_found
    end

    it 'creates message' do
      create :participation, user: current_user, conversation: conversation
      post :create, params: message_params
      message = conversation.messages.order(created_at: :desc).first
      expect(message.body).to eq 'shiny new message'
      expect(message.user).to eq current_user
    end

    it 'updates conversation updated_at' do
      create :participation, user: current_user, conversation: conversation
      Timecop.freeze(Time.zone.now.round) do
        post :create, params: message_params
        expect(conversation.reload.updated_at).to eq Time.zone.now.round
      end
    end

    it 'updates participant read_at' do
      participation = create :participation, user: current_user, conversation: conversation, read_at: 30.minutes.ago
      Timecop.freeze(Time.zone.now.round) do
        post :create, params: message_params
        expect(participation.reload.read_at).to eq Time.zone.now.round
      end
    end
  end
end
