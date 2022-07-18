require 'rails_helper'

RSpec.describe Admin, type: :model do
  describe '#create' do
    let!(:admin) { create(:admin) }
    let(:new_admin) { build(:admin) }
    let(:email_is_null_admin) { build(:admin, email: null) }
    let(:duplicate_email_admin) { build(:admin, email: admin.email) }
    let(:password_match_admin) { build(:admin, password: 'password', password_confirmation: 'password') }
    let(:password_not_match_admin) { build(:admin, password: 'password123', password_confirmation: 'password456') }
    let(:password_has_less_digits_admin) { build(:admin, password: '12345', password_confirmation: '12345') }

    it "when admin registration, it registration is possible" do
      expect(new_admin).to be_valid
    end

    it "when duplicate email, it registration is not possible" do
      expect(duplicate_email_admin).not_to be_valid
    end

    it "when password match, it registration is possible" do
      expect(password_match_admin).to be_valid
    end

    it "when password not match, it registration is not possible" do
      expect(password_not_match_admin).not_to be_valid
    end

    it "when password has less digits, it registration is not possible" do
      expect(password_has_less_digits_admin).not_to be_valid
    end
  end

  describe '#update' do
    let(:admin) { create(:admin) }
    let!(:admin1) { create(:admin) }

    it "when have not change, it can be updated" do
      expect(admin).to be_valid
    end

    it "when change email, it can be updated" do
      admin.email = 'change_email@gmail.com'
      expect(admin).to be_valid
    end

    it "when change duplicate email, it can be not updated" do
      admin.email = admin1.email
      expect(admin).not_to be_valid
    end

    it "when change password for match, it can be updated" do
      admin.password = 'change_password'
      admin.password_confirmation = 'change_password'
      expect(admin).to be_valid
    end

    it "when change password for not match, it can be not updated" do
      admin.password = 'change_password123'
      admin.password_confirmation = 'change_password456'
      expect(admin).not_to be_valid
    end

    it "when change password less digits, it can be not updated" do
      admin.password = '12345'
      admin.password_confirmation = '12345'
      expect(admin).not_to be_valid
    end
  end

  describe '#destroy' do
    let(:admin) { create(:admin) }

    it "when admin destory, deleted" do
      admin.destroy
      expect(Admin.exists?(id: admin.id)).to be false
    end
  end
end
