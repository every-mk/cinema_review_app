require 'rails_helper'

RSpec.describe "Cinemas", type: :request do
  let(:cinema) { create(:cinema) }

  describe "GET /index" do
    it "returns http success" do
      get "/cinemas"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /new" do
    it "returns http success" do
      get "/cinemas/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /edit" do
    it "returns http success" do
      get "/cinemas/#{cinema.id}/edit"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/cinemas/#{cinema.id}"
      expect(response).to have_http_status(:success)
    end
  end
end
