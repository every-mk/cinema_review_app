require 'rails_helper'

RSpec.describe "Review", type: :system do
  let!(:user) { create(:user, profile: profile) }
  let(:profile) { build(:profile) }
  let(:cinema) { create(:cinema) }
  let(:cinema1) { create(:cinema, title: "title1") }
  let!(:review) { create(:review, user: user, cinema: cinema) }
  let(:build_review) { build(:review, user: user, cinema: cinema1) }

  before do
    profile.image.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'profile', 'default_icon.jpeg')), filename: 'default_icon.jpeg', content_type: 'image/jpeg')
    user.confirm
    cinema.image.attach(io: File.open(Rails.root.join('spec', 'fixtures', 'cinema', 'sample_01.png')), filename: 'sample_01.png', content_type: 'image/png')
    cinema1.image.attach(io: File.open(Rails.root.join('spec', 'fixtures', 'cinema', 'sample_01.png')), filename: 'sample_01.png', content_type: 'image/png')
  end

  describe "review#new" do
    before do
      sign_in user
      visit cinema_path(cinema1)
      visit new_review_path(cinema_id: cinema.id)
    end

    it "when displayed, the content is displayed correctly" do
      expect(page).to have_selector 'h1', text: "レビュー新規作成"
      expect(page).to have_content "おすすめ"
      expect(page).to have_content "また観たい"
      expect(page).to have_content "忘れた頃に観たい"
      expect(page).to have_content "もう観たくない"
      expect(page).to have_content "ネタバレ"
      expect(page).to have_content "評価内容"
      expect(page).to have_selector "input[value='作成']"
      expect(page).to have_content "戻る"
    end

    scenario "when all fill, created" do
      check "おすすめ"
      choose "また観たい"
      check "ネタバレ"
      fill_in "review_content", with: build_review.content

      expect do
        click_button "作成"
        expect(page).to have_content "レビューを作成しました"
      end.to change(Review, :count).by(1)
    end

    scenario "when recommendation is uncheck, created" do
      uncheck "おすすめ"
      choose "また観たい"
      check "ネタバレ"
      fill_in "review_content", with: build_review.content

      expect do
        click_button "作成"
        expect(page).to have_content "レビューを作成しました"
      end.to change(Review, :count).by(1)
    end

    scenario "when after watch is want to see when forget, created" do
      uncheck "おすすめ"
      choose "忘れた頃に観たい"
      check "ネタバレ"
      fill_in "review_content", with: build_review.content

      expect do
        click_button "作成"
        expect(page).to have_content "レビューを作成しました"
      end.to change(Review, :count).by(1)
    end

    scenario "when after watch is do not want to see, created" do
      uncheck "おすすめ"
      choose "もう観たくない"
      check "ネタバレ"
      fill_in "review_content", with: build_review.content

      expect do
        click_button "作成"
        expect(page).to have_content "レビューを作成しました"
      end.to change(Review, :count).by(1)
    end

    scenario "when spoiler is uncheck, created" do
      check "おすすめ"
      choose "また観たい"
      uncheck "ネタバレ"
      fill_in "review_content", with: build_review.content

      expect do
        click_button "作成"
        expect(page).to have_content "レビューを作成しました"
      end.to change(Review, :count).by(1)
    end

    scenario "when content is not fill, not created" do
      check "おすすめ"
      choose "また観たい"
      uncheck "ネタバレ"
      click_button "作成"
      expect(page).to have_content "評価内容を入力してください"
    end

    scenario "when you back click the link, will be displayed", js: true do
      click_link "戻る"
      expect(page).to have_content "レビューを書く"
    end
  end

  describe "review#edit" do
    before do
      sign_in user
      visit cinema_path(cinema)
      visit edit_review_path(review.id)
    end

    it "when displayed, the content is displayed correctly" do
      expect(page).to have_selector 'h1', text: "レビュー編集"
      expect(page).to have_content "おすすめ"
      expect(page).to have_content "また観たい"
      expect(page).to have_content "忘れた頃に観たい"
      expect(page).to have_content "もう観たくない"
      expect(page).to have_content "ネタバレ"
      expect(page).to have_content "評価内容"
      expect(page).to have_selector "input[value='更新']"
      expect(page).to have_content "戻る"
    end

    scenario "when all fill, updated" do
      check "おすすめ"
      choose "また観たい"
      check "ネタバレ"
      fill_in "review_content", with: build_review.content

      click_button "更新"
      expect(page).to have_content "レビューを更新しました"
    end

    scenario "when recommendation is uncheck, updated" do
      choose "また観たい"
      click_button "更新"
      expect(page).to have_content "レビューを更新しました"
    end

    scenario "when after watch is want to see when forget, updated" do
      choose "忘れた頃に観たい"
      click_button "更新"
      expect(page).to have_content "レビューを更新しました"
    end

    scenario "when after watch is do not want to see, updated" do
      choose "もう観たくない"
      click_button "更新"
      expect(page).to have_content "レビューを更新しました"
    end

    scenario "when spoiler is uncheck, updated" do
      uncheck "ネタバレ"
      click_button "更新"
      expect(page).to have_content "レビューを更新しました"
    end

    scenario "when content is not fill, not updated" do
      fill_in "review_content", with: nil
      click_button "更新"
      expect(page).to have_content "評価内容を入力してください"
    end

    scenario "when you back click the link, will be displayed", js: true do
      click_link "戻る"
      expect(page).to have_content "レビューを編集する"
    end
  end
end
