require 'rails_helper'

RSpec.describe Profile, type: :model do
  describe '#create' do
    let(:user) { build(:user, profile: profile) }
    let(:profile) { build(:profile) }

    it "when user registration, it profile registration is possible" do
      expect(user.profile).to be_valid
    end

    it "when name is nil, it registration is not possible" do
      profile.name = nil
      expect(user.profile).not_to be_valid
    end

    it "when name is present, it registration is possible" do
      profile.name = 'ユーザー'
      expect(user.profile).to be_valid
    end

    it "when sex is nil, it registration is not possible" do
      profile.sex = nil
      expect(user.profile).not_to be_valid
    end

    it "when sex is present, it registration is possible" do
      profile.sex = 0
      expect(user.profile).to be_valid
    end

    it "when date of birth is nil, it registration is not possible" do
      profile.date_of_birth = nil
      expect(user.profile).not_to be_valid
    end

    it "when date of birth is present, it registration is possible" do
      profile.date_of_birth = '2022/07/01'
      expect(user.profile).to be_valid
    end

    it "when prefecture is nil, it registration is not possible" do
      profile.prefecture = nil
      expect(user.profile).not_to be_valid
    end

    it "when prefecture is present, it registration is possible" do
      profile.prefecture = '沖縄県'
      expect(user.profile).to be_valid
    end

    it "when municipality is nil, it registration is not possible" do
      profile.municipality = nil
      expect(user.profile).not_to be_valid
    end

    it "when municipality is present, it registration is possible" do
      profile.municipality = '那覇市'
      expect(user.profile).to be_valid
    end
  end

  describe '#update' do
    let(:user) { create(:user, profile: profile) }
    let(:profile) { build(:profile) }

    it "when have not change, it can be updated" do
      expect(user.profile).to be_valid
    end

    it "when name is nil, it can be not updated" do
      profile.name = nil
      expect(user.profile).not_to be_valid
    end

    it "when name is present, it can be updated" do
      profile.name = 'ユーザー'
      expect(user.profile).to be_valid
    end

    it "when sex is nil, iit can be not updated" do
      profile.sex = nil
      expect(user.profile).not_to be_valid
    end

    it "when sex is present, it can be updated" do
      profile.sex = 0
      expect(user.profile).to be_valid
    end

    it "when date of birth is nil, it can be not updated" do
      profile.date_of_birth = nil
      expect(user.profile).not_to be_valid
    end

    it "when date of birth is present, it can be updated" do
      profile.date_of_birth = '2022/07/01'
      expect(user.profile).to be_valid
    end

    it "when prefecture is nil, it can be not updated" do
      profile.prefecture = nil
      expect(user.profile).not_to be_valid
    end

    it "when prefecture is present, it can be updated" do
      profile.prefecture = '沖縄県'
      expect(user.profile).to be_valid
    end

    it "when municipality is nil, it can be not updated" do
      profile.municipality = nil
      expect(user.profile).not_to be_valid
    end

    it "when municipality is present, it can be updated" do
      profile.municipality = '那覇市'
      expect(user.profile).to be_valid
    end
  end

  describe '#destroy' do
    let(:user) { create(:user, profile: profile) }
    let(:profile) { build(:profile) }

    it "when user destory, profile deleted" do
      user.destroy
      expect(Profile.exists?(user_id: user.id)).to be false
    end
  end
end
