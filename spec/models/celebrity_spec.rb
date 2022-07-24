require 'rails_helper'

RSpec.describe Celebrity, type: :model do
  STRING_LEN_21 = "123456789012345678901"
  STRING_LEN_1001 = "12345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901"

  describe '#create' do
    let!(:celebrity) { create(:celebrity) }
    let(:new_celebrity) { build(:celebrity) }

    it "when celebrity registration, it registration is possible" do
      expect(new_celebrity).to be_valid
    end

    it "when name is nil, it registration is not possible" do
      new_celebrity.name = nil
      expect(new_celebrity).not_to be_valid
    end

    it "when name more digits, it registration is not possible" do
      new_celebrity.name = STRING_LEN_21
      expect(new_celebrity).not_to be_valid
    end

    it "when ruby is nil, it registration is not possible" do
      new_celebrity.ruby = nil
      expect(new_celebrity).not_to be_valid
    end

    it "when ruby more digits, it registration is not possible" do
      new_celebrity.ruby = STRING_LEN_21
      expect(new_celebrity).not_to be_valid
    end

    it "when date of birth is nil, it registration is not possible" do
      new_celebrity.date_of_birth = nil
      expect(new_celebrity).not_to be_valid
    end

    it "when birthplace is nil, it registration is not possible" do
      new_celebrity.birthplace = nil
      expect(new_celebrity).not_to be_valid
    end

    it "when birthplace more digits, it registration is not possible" do
      new_celebrity.birthplace = STRING_LEN_21
      expect(new_celebrity).not_to be_valid
    end

    it "when history is nil, it registration is not possible" do
      new_celebrity.history = nil
      expect(new_celebrity).not_to be_valid
    end

    it "when history more digits, it registration is not possible" do
      new_celebrity.history = STRING_LEN_1001
      expect(new_celebrity).not_to be_valid
    end
  end

  describe '#update' do
    let(:celebrity) { create(:celebrity) }

    it "when have not change, it can be updated" do
      expect(celebrity).to be_valid
    end

    it "when name is nil, it can be not updated" do
      celebrity.name = nil
      expect(celebrity).not_to be_valid
    end

    it "when name more digits, it can be not updated" do
      celebrity.name = STRING_LEN_21
      expect(celebrity).not_to be_valid
    end

    it "when ruby is nil, it can be not updated" do
      celebrity.ruby = nil
      expect(celebrity).not_to be_valid
    end

    it "when ruby more digits, it can be not updated" do
      celebrity.ruby = STRING_LEN_21
      expect(celebrity).not_to be_valid
    end

    it "when date of birth is nil, it can be not updated" do
      celebrity.date_of_birth = nil
      expect(celebrity).not_to be_valid
    end

    it "when birthplace is nil, it can be not updated" do
      celebrity.birthplace = nil
      expect(celebrity).not_to be_valid
    end

    it "when birthplace more digits, it can be not updated" do
      celebrity.birthplace = STRING_LEN_21
      expect(celebrity).not_to be_valid
    end

    it "when history is nil, it can be not updated" do
      celebrity.history = nil
      expect(celebrity).not_to be_valid
    end

    it "when history more digits, it can be not updated" do
      celebrity.history = STRING_LEN_1001
      expect(celebrity).not_to be_valid
    end
  end

  describe '#destroy' do
    let(:celebrity) { create(:celebrity) }

    it "when celebrity destory, deleted" do
      celebrity.destroy
      expect(Celebrity.exists?(id: celebrity.id)).to be false
    end
  end
end
