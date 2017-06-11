require 'rails_helper'

RSpec.describe Participation, type: :model do
  it 'must be unique for user and conversation' do
    participation = create :participation
    expect(build :participation, user: participation.user, conversation: participation.conversation).not_to be_valid
  end

  describe '#user' do
    it 'must be present' do
      expect(build :participation, user: nil).not_to be_valid
    end
  end

  describe '#conversation' do
    it 'must be present' do
      expect(build :participation, conversation: nil).not_to be_valid
    end
  end
end
