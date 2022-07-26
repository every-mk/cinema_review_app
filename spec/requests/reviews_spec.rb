require 'rails_helper'

RSpec.describe "Reviews", type: :request do
  let(:user) { create(:user) }
  let(:cinema) { create(:cinema) }
  let(:review) { create(:review, user: user, cinema: cinema) }

  describe "GET /new" do
    it "returns http success" do
      get "/reviews/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /edit" do
    it "returns http success" do
      get "/reviews/#{review.id}/edit"
      expect(response).to have_http_status(:success)
    end
  end
end
