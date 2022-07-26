require 'rails_helper'

RSpec.describe "Cinemas", type: :request do
  let(:cinema) { create(:cinema) }

  before do
    cinema.image.attach(io: File.open(Rails.root.join('spec', 'fixtures', 'cinema', 'sample_01.png')), filename: 'sample_01.png', content_type: 'image/png')
  end

  describe "GET /index" do
    it "returns http success" do
      get "/"
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
