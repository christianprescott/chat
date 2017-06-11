require "rails_helper"

shared_examples_for 'user authenticated resource' do
  context 'without username' do
    let(:current_username) { nil }

    it 'responds 401' do
      make_request
      expect(response).to have_http_status :unauthorized
    end
  end

  context 'with new username' do
    let(:current_username) { 'newUser' }

    it 'creates user' do
      expect { make_request }.to change { User.count }.by 1
      expect(response).to have_http_status :success
    end
  end

  context 'with existing username' do
    it 'responds 200 when username is present' do
      expect { make_request }.not_to change { User.count }
      expect(response).to have_http_status :success
    end
  end
end
