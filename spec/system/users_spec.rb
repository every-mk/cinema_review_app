require 'rails_helper'

RSpec.describe "Users", type: :system do
  let(:user) { create(:user, profile: profile) }
  let(:profile) { build(:profile) }

  before do
    profile.image.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'profile', 'default_icon.jpeg')), filename: 'default_icon.jpeg', content_type: 'image/jpeg')
    user.confirm
  end

  describe "#account" do
    before do
      sign_in user
      visit users_account_path
      allow(controller).to receive(:current_user).and_return(user)
    end

    it 'when displayed, the header is displayed correctly' do
      expect(page).to have_selector "img[alt=サイトのロゴ画像]"
      # ToDo: サイトのログ画像URLを追加する.
      expect(page).to have_selector "img[alt=アイコン画像]"
      expect(page).to have_selector "img[src='#{url_for(profile.image.attachment)}']"
    end

    it 'when displayed, the content is displayed correctly' do
      expect(page).to have_selector 'li', text: "アカウント"
      expect(page).to have_selector 'li', text: "プロファイル"
      expect(page).to have_selector 'p', text: "アカウント"
      expect(page).to have_content "プロファイル"
      expect(page).to have_content "メールアドレス"
      expect(page).to have_content user.email
      expect(page).to have_content "*********"
      expect(page).to have_content "編集"
      expect(page).to have_content "アカウント削除"
    end

    it 'when displayed, the footer is displayed correctly' do
      expect(page).to have_content "©︎ 2022 S.K"
    end

    scenario 'when you pc version account click the link, the account information will be displayed' do
      find("div[class='user-nav user-nav-pc']").click_on "アカウント"
      expect(page).to have_selector 'p', text: "アカウント"
    end

    scenario 'when you mobile version account click the link, the account information will be displayed' do
      find("div[class='user-nav user-nav-mobile']").click_on "アカウント"
      expect(page).to have_selector 'p', text: "アカウント"
    end

    scenario 'when you pc version profile click the link, the profile information will be displayed' do
      find("div[class='user-nav user-nav-pc']").click_on "プロファイル"
      expect(page).to have_selector 'p', text: "プロファイル"
    end

    scenario 'when you mobile version profile click the link, the profile information will be displayed' do
      find("div[class='user-nav user-nav-mobile']").click_on "プロファイル"
      expect(page).to have_selector 'p', text: "プロファイル"
    end

    scenario 'when you edit click the link, the account edit will be displayed' do
      click_link "編集"
      expect(page).to have_selector 'h1', text: "アカウント編集"
    end

    scenario 'when you account delete click the link, account deleted', js: true do
      click_link "アカウント削除"
      expect(page.accept_confirm).to eq "本当に削除しますか？"
      expect(page).to have_content "アカウントを削除しました"
      expect(User.exists?(id: user.id)).to be false
    end
  end
end
