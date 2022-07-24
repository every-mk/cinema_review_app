require 'rails_helper'

RSpec.describe Review, type: :model do
  describe '#create' do
    let(:review) { build(:review) }

    it "when review registration, it registration is possible" do
      expect(review).to be_valid
    end

    it "when want to see is nil, it registration is not possible" do
      review.want_to_see = nil
      expect(review).not_to be_valid
    end

    it "when recommendation is nil, it registration is not possible" do
      review.recommendation = nil
      expect(review).not_to be_valid
    end

    it "when after watch is nil, it registration is not possible" do
      review.after_watch = nil
      expect(review).not_to be_valid
    end

    it "when after watch is present, it registration is possible" do
      review.after_watch = 2
      expect(review).to be_valid
    end

    it "when spoiler is nil, it registration is not possible" do
      review.spoiler = nil
      expect(review).not_to be_valid
    end

    it "when content is nil, it registration is not possible" do
      review.content = nil
      expect(review).not_to be_valid
    end
  end

  describe '#update' do
    let(:review) { create(:review) }

    it "when have not change, it can be updated" do
      expect(review).to be_valid
    end

    it "when want to see is nil, it can be not updated" do
      review.want_to_see = nil
      expect(review).not_to be_valid
    end

    it "when recommendation is nil, it can be not updated" do
      review.recommendation = nil
      expect(review).not_to be_valid
    end

    it "when after watch is nil, it can be not updated" do
      review.after_watch = nil
      expect(review).not_to be_valid
    end

    it "when after watch is present, it can be updated" do
      review.after_watch = 2
      expect(review).to be_valid
    end

    it "when spoiler is nil, it can be not updated" do
      review.spoiler = nil
      expect(review).not_to be_valid
    end

    it "when content is nil, it can be not updated" do
      review.content = nil
      expect(review).not_to be_valid
    end
  end

  describe '#destroy' do
    let(:review) { create(:review) }

    it "when review destory, deleted" do
      review.destroy
      expect(Review.exists?(id: review.id)).to be false
    end
  end
end
