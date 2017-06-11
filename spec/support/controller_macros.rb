module ControllerMacros
  extend ActiveSupport::Concern

  included do
    let(:current_user) { create :user }
    let(:current_username) { current_user.name }
    let(:json) { JSON.parse(response.body) }

    before do
      allow(controller).to receive(:current_username).and_return(current_username)
    end
  end
end
