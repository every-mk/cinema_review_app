require 'rails_helper'

RSpec.describe "Admins", type: :system do
  let!(:admin) { create(:admin) }
  let(:build_admin) { build(:admin, email: "build_admin@gmail.com") }
  let(:guest_admin) { create(:user, email: "guest@example.com") }

  describe "#sign_up" do
    before do
      visit new_admin_registration_path
    end

    it "when displayed, the content is displayed correctly" do
      expect(page).to have_selector 'h1', text: "新しい管理者を作成"
      expect(page).to have_content "Eメール"
      expect(page).to have_content "パスワード"
      expect(page).to have_content "パスワード（確認用）"
      expect(page).to have_selector "input[value='新しい管理者を作成']"
    end

    scenario "when all fill, created account" do
      fill_in "admin_email", with: build_admin.email
      fill_in "admin_password", with: build_admin.password
      fill_in "admin_password_confirmation", with: build_admin.password_confirmation

      expect do
        click_button "新しい管理者を作成"
        expect(page).to have_content "アカウント登録が完了しました。"
      end.to change(Admin, :count).by(1)
    end

    scenario "when email is fill, not created account" do
      fill_in "admin_password", with: build_admin.password
      fill_in "admin_password_confirmation", with: build_admin.password_confirmation
      click_button "新しい管理者を作成"
      expect(page).to have_content "Eメールを入力してください"
    end

    scenario "if account has been verified, no email will be sent." do
      fill_in "admin_email", with: admin.email
      fill_in "admin_password", with: build_admin.password
      fill_in "admin_password_confirmation", with: build_admin.password_confirmation
      click_button "新しい管理者を作成"
      expect(page).to have_content "Eメールはすでに存在します"
    end

    scenario "when password is fill, not created account" do
      fill_in "admin_email", with: build_admin.email
      fill_in "admin_password_confirmation", with: build_admin.password_confirmation
      click_button "新しい管理者を作成"
      expect(page).to have_content "パスワードを入力してください"
    end

    scenario "when password confirmation is fill, not created account" do
      fill_in "admin_email", with: build_admin.email
      fill_in "admin_password", with: build_admin.password
      click_button "新しい管理者を作成"
      expect(page).to have_content "パスワード（確認用）とパスワードの入力が一致しません"
    end
  end

  describe "#sign_in" do
    describe "user logined" do
      before do
        visit new_admin_session_path
      end

      it "when displayed, the content is displayed correctly" do
        expect(page).to have_selector 'h1', text: "管理者ログイン"
        expect(page).to have_content "Eメール"
        expect(page).to have_content "パスワード"
        expect(page).to have_selector "input[value='ログイン']"
      end

      scenario "when all fill, logined" do
        fill_in "admin_email", with: admin.email
        fill_in "admin_password", with: build_admin.password
        click_button "ログイン"
        expect(page).to have_content "ログインしました。"
      end

      scenario "when email is not fill, not logined" do
        fill_in "admin_password", with: build_admin.password
        click_button "ログイン"
        expect(page).to have_content "Eメールまたはパスワードが違います。"
      end

      scenario "when password is not fill, not logined" do
        fill_in "admin_email", with: admin.email
        click_button "ログイン"
        expect(page).to have_content "Eメールまたはパスワードが違います。"
      end

      scenario "when password is wrong, not logined" do
        fill_in "admin_email", with: admin.email
        fill_in "admin_password", with: "wrong_password"
        click_button "ログイン"
        expect(page).to have_content "Eメールまたはパスワードが違います。"
      end
    end
  end

  describe "guest user logined" do
    before do
      visit new_admin_session_path
    end

    scenario "when you guest login click the link, logined" do
      click_link "ゲストログイン"
      expect(page).to have_content "ログインしました。"
    end
  end
end
