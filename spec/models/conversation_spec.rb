require 'rails_helper'

RSpec.describe Conversation, type: :model do
  let_once(:user) { create :user }
  let_once(:conversation) { create :conversation, created_at: 2.hours.ago, updated_at: 2.minutes.ago }

  describe '.include_unread' do
    it 'selects true when conversation updated since last read' do
      create :participation, user: user, conversation: conversation, read_at: 1.hour.ago
      conversations = user.conversations.include_unread
      expect(conversations.first.attributes['unread']).to eq true
    end

    it 'selects false when read since conversation last updated' do
      create :participation, user: user, conversation: conversation, read_at: 1.minute.ago
      conversations = user.conversations.include_unread
      expect(conversations.first.attributes['unread']).to eq false
    end

    it 'selects true when conversation never read' do
      create :participation, user: user, conversation: conversation, read_at: nil
      conversations = user.conversations.include_unread
      expect(conversations.first.attributes['unread']).to eq true
    end
  end
end
