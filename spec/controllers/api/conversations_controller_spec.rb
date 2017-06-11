require "rails_helper"

RSpec.describe Api::ConversationsController, type: :controller do
  it "responds 401 when user_id param is not present" do
    get :index
    expect(response).to have_http_status :unauthorized
  end

  it "responds 200 when user_id param is present" do
    get :index, params: { user_id: 1 }
    expect(response).to have_http_status :success
  end
end
