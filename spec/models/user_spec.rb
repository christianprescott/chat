require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#name' do
    it 'must be present' do
      user = build :user, name: ''
      expect(user).not_to be_valid
    end

    it 'must be unique' do
      create :user, name: 'xXhypeb345tXx'
      user = build :user, name: 'xXhypeb345tXx'
      expect(user).not_to be_valid
    end
  end
end
