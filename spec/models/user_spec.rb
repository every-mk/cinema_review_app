require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#create' do
    let!(:user) { create(:user) }
    let(:new_user) { build(:user) }
    let(:email_is_null_user) { build(:user, email: null) }
    let(:duplicate_email_user) { build(:user, email: user.email) }
    let(:password_match_user) { build(:user, password: 'password', password_confirmation: 'password') }
    let(:password_not_match_user) { build(:user, password: 'password123', password_confirmation: 'password456') }
    let(:password_has_less_digits_user) { build(:user, password: '12345', password_confirmation: '12345') }

    it "when user registration, it registration is possible" do
      expect(new_user).to be_valid
    end

    it "when duplicate email, it registration is not possible" do
      expect(duplicate_email_user).not_to be_valid
    end

    it "when password match, it registration is possible" do
      expect(password_match_user).to be_valid
    end

    it "when password not match, it registration is not possible" do
      expect(password_not_match_user).not_to be_valid
    end

    it "when password has less digits, it registration is not possible" do
      expect(password_has_less_digits_user).not_to be_valid
    end
  end

  describe '#update' do
    let!(:user) { create(:user) }
    let!(:user1) { create(:user) }

    it "when have not change, it can be updated" do
      expect(user).to be_valid
    end

    it "when change email, it can be updated" do
      user.email = 'change_email@gmail.com'
      expect(user).to be_valid
    end

    it "when change duplicate email, it can be not updated" do
      user.email = user1.email
      expect(user).not_to be_valid
    end

    it "when change password for match, it can be updated" do
      user.password = 'change_password'
      user.password_confirmation = 'change_password'
      expect(user).to be_valid
    end

    it "when change password for not match, it can be not updated" do
      user.password = 'change_password123'
      user.password_confirmation = 'change_password456'
      expect(user).not_to be_valid
    end

    it "when change password less digits, it can be not updated" do
      user.password = '12345'
      user.password_confirmation = '12345'
      expect(user).not_to be_valid
    end
  end

  describe '#destroy' do
    let(:user) { create(:user) }

    it "when user destory, deleted" do
      user.destroy
      expect(User.exists?(id: user.id)).to be false
    end
  end
end
