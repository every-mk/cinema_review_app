require 'rails_helper'

RSpec.describe "Genres", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/genres/"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /new" do
    it "returns http success" do
      get "/genres/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /edit" do
    it "returns http success" do
      get "/genres/edit"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/genres/show"
      expect(response).to have_http_status(:success)
    end
  end
end
