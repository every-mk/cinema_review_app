require 'rails_helper'

RSpec.describe Genre, type: :model do
  describe '#create' do
    let(:new_genre) { build(:genre) }

    it "when genre registration, it registration is possible" do
      expect(new_genre).to be_valid
    end

    it "when name is nil, it registration is not possible" do
      new_genre.name = nil
      expect(new_genre).not_to be_valid
    end
  end
end
