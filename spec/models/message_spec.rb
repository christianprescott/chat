require 'rails_helper'

RSpec.describe Message, type: :model do
  describe '#body' do
    it 'must be present' do
      expect(build :message, body: '').not_to be_valid
    end
  end
end
