require 'rails_helper'

RSpec.describe "Celebrities", type: :request do
  let(:celebrity) { create(:celebrity) }

  before do
    celebrity.image.attach(io: File.open(Rails.root.join('spec', 'fixtures', 'celebrity', 'sample_icon.jpeg')), filename: 'default_icon.jpeg', content_type: 'image/jpeg')
  end

  describe "GET /new" do
    it "returns http success" do
      get "/celebrities/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /edit" do
    it "returns http success" do
      get "/celebrities/#{celebrity.id}/edit"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/celebrities/#{celebrity.id}"
      expect(response).to have_http_status(:success)
    end
  end
end
