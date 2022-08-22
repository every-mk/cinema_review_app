require 'rails_helper'

RSpec.describe "Genre", type: :system do
  let(:admin) { create(:admin) }
  let(:guest_admin) { create(:admin, email: "guest@example.com") }
  let(:user) { create(:user, profile: profile) }
  let(:guest_user) { create(:user, email: "guest@example.com", profile: profile1) }
  let(:profile) { build(:profile) }
  let(:profile1) { build(:profile) }
  let!(:genre) { create(:genre, id: 1, name: "genre1") }
  let(:build_genre) { build(:genre, id: 2, name: "genre2") }

  before do
    profile.image.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'profile', 'default_icon.jpeg')), filename: 'default_icon.jpeg', content_type: 'image/jpeg')
    profile1.image.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'profile', 'default_icon.jpeg')), filename: 'default_icon.jpeg', content_type: 'image/jpeg')
    user.confirm
    guest_user.confirm
  end

  describe "genre#index" do
    before do
      sign_in admin
      visit admins_path
      visit genres_path
    end

    it "when displayed, the content is displayed genre" do
      expect(page).to have_selector 'h1', text: "ジャンル"
      expect(page).to have_content "Id"
      expect(page).to have_content "ジャンル名"
      expect(page).to have_content "ジャンル 新規作成"
      expect(page).to have_content "戻る"
    end

    scenario "when genre click, go to edit" do
      click_link genre.name
      expect(page).to have_content "ジャンル編集"
    end

    scenario "when genre click, go to new" do
      click_link "ジャンル 新規作成"
      expect(page).to have_content "ジャンル新規作成"
    end

    scenario "when you back click the link, will be displayed", js: true do
      click_link "戻る"
      expect(page).to have_content "ジャンル"
    end
  end

  describe "genre#new" do
    before do
      sign_in admin
      visit genres_path
      visit new_genre_path
    end

    it "when displayed, the content is displayed correctly" do
      expect(page).to have_selector 'h1', text: "ジャンル新規作成"
      expect(page).to have_content "ジャンル名"
      expect(page).to have_selector "input[value='作成']"
      expect(page).to have_content "戻る"
    end

    scenario "when all fill, created" do
      fill_in "genre_name", with: build_genre.name

      expect do
        click_button "作成"
        expect(page).to have_content "ジャンルを作成しました"
      end.to change(Genre, :count).by(1)
    end

    scenario "when name is not fill, not created" do
      click_button "作成"
      expect(page).to have_content "ジャンル名を入力してください"
    end

    scenario "when duplicate name, not created" do
      fill_in "genre_name", with: genre.name
      click_button "作成"
      expect(page).to have_content "ジャンル名はすでに存在します"
    end

    scenario "when you back click the link, will be displayed", js: true do
      click_link "戻る"
      expect(page).to have_content "ジャンル"
    end
  end

  describe "genre#edit" do
    describe "admin logined" do
      before do
        sign_in admin
        visit genres_path
        visit edit_genre_path(genre)
      end

      it "when displayed, the content is displayed correctly" do
        expect(page).to have_selector 'h1', text: "ジャンル編集"
        expect(page).to have_selector "input[value='更新']"
        expect(page).to have_content "削除"
        expect(page).to have_content "戻る"
      end

      scenario "when all fill, updated" do
        fill_in "genre_name", with: build_genre.name
        click_button "更新"
        expect(page).to have_content "ジャンル名を更新しました"
      end

      scenario "when name is not fill, not updated" do
        fill_in "genre_name", with: nil
        click_button "更新"
        expect(page).to have_content "ジャンル名を入力してください"
      end

      scenario "when you genre delete click the link, deleted", js: true do
        click_link "削除"
        expect(page.accept_confirm).to eq "本当に削除しますか？"
        expect(page).to have_content "ジャンル名を削除しました"
        expect(Genre.exists?(id: genre.id)).to be false
      end

      scenario "when you back click the link, the account will be displayed", js: true do
        click_link "戻る"
        expect(page).to have_content "ジャンル"
      end
    end

    describe "guest admin logined" do
      before do
        sign_in guest_admin
        visit edit_genre_path(genre)
      end

      scenario "when you genre delete click the link, deleted", js: true do
        click_link "削除"
        expect(page.accept_confirm).to eq "本当に削除しますか？"
        expect(page).to have_content "ゲストユーザーは削除権限がありません"
        expect(Genre.exists?(id: genre.id)).to be true
      end
    end
  end
end
