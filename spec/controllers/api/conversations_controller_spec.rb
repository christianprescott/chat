require "rails_helper"

RSpec.describe Api::ConversationsController, type: :controller do
  it "responds 401 when username is not present" do
    get :index
    expect(response).to have_http_status :unauthorized
  end

  it "responds 200 when username is present" do
    create :user, name: 'existingUser'
    expect { get :index, params: { username: 'existingUser' } }.not_to change { User.count }
    expect(response).to have_http_status :success
  end

  it "creates user when one does not exist" do
    expect { get :index, params: { username: 'newUser' } }.to change { User.count }.by 1
    expect(response).to have_http_status :success
  end
end
