require 'rails_helper'

RSpec.describe "Celebrity", type: :system do
  let(:admin) { create(:admin) }
  let(:guest_admin) { create(:admin, email: "guest@example.com") }
  let(:user) { create(:user, profile: profile) }
  let(:guest_user) { create(:user, email: "guest@example.com", profile: profile1) }
  let(:profile) { build(:profile) }
  let(:profile1) { build(:profile) }
  let(:celebrity) { create(:celebrity) }
  let(:build_celebrity) { build(:celebrity) }

  before do
    profile.image.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'profile', 'default_icon.jpeg')), filename: 'default_icon.jpeg', content_type: 'image/jpeg')
    profile1.image.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'profile', 'default_icon.jpeg')), filename: 'default_icon.jpeg', content_type: 'image/jpeg')
    user.confirm
    guest_user.confirm
    celebrity.image.attach(io: File.open(Rails.root.join('spec', 'fixtures', 'celebrity', 'sample_icon.jpeg')), filename: 'default_icon.jpeg', content_type: 'image/jpeg')
  end

  describe "celebrity#new" do
    before do
      sign_in admin
      visit admins_path
      visit new_celebrity_path
    end

    it "when displayed, the content is displayed correctly" do
      expect(page).to have_selector 'p', text: "著名人新規作成"
      expect(page).to have_content "著名人画像"
      expect(page).to have_content "ふりがな"
      expect(page).to have_content "名前"
      expect(page).to have_content "生年月日"
      expect(page).to have_content "出身地"
      expect(page).to have_content "歴史"
      expect(page).to have_selector "input[value='作成']"
      expect(page).to have_content "戻る"
    end

    scenario "when all fill, created account" do
      attach_file 'celebrity_image', "#{Rails.root}/spec/fixtures/celebrity/sample_icon.jpeg"
      fill_in "celebrity_name", with: build_celebrity.name
      fill_in "celebrity_ruby", with: build_celebrity.ruby
      fill_in "celebrity_date_of_birth", with: build_celebrity.date_of_birth
      fill_in "celebrity_birthplace", with: build_celebrity.birthplace
      fill_in "celebrity_history", with: build_celebrity.history

      expect do
        click_button "作成"
        expect(page).to have_content "著名人を作成しました"
      end.to change(Celebrity, :count).by(1)
    end

    scenario "when name is not fill, not created" do
      attach_file 'celebrity_image', "#{Rails.root}/spec/fixtures/celebrity/sample_icon.jpeg"
      fill_in "celebrity_ruby", with: build_celebrity.ruby
      fill_in "celebrity_date_of_birth", with: build_celebrity.date_of_birth
      fill_in "celebrity_birthplace", with: build_celebrity.birthplace
      fill_in "celebrity_history", with: build_celebrity.history
      click_button "作成"
      expect(page).to have_content "名前を入力してください"
    end

    scenario "when ruby is not fill, not created" do
      attach_file 'celebrity_image', "#{Rails.root}/spec/fixtures/celebrity/sample_icon.jpeg"
      fill_in "celebrity_name", with: build_celebrity.name
      fill_in "celebrity_date_of_birth", with: build_celebrity.date_of_birth
      fill_in "celebrity_birthplace", with: build_celebrity.birthplace
      fill_in "celebrity_history", with: build_celebrity.history
      click_button "作成"
      expect(page).to have_content "ふりがなを入力してください"
    end

    scenario "when date of birth is not fill, not created" do
      attach_file 'celebrity_image', "#{Rails.root}/spec/fixtures/celebrity/sample_icon.jpeg"
      fill_in "celebrity_name", with: build_celebrity.name
      fill_in "celebrity_ruby", with: build_celebrity.ruby
      fill_in "celebrity_birthplace", with: build_celebrity.birthplace
      fill_in "celebrity_history", with: build_celebrity.history
      click_button "作成"
      expect(page).to have_content "生年月日を入力してください"
    end

    scenario "when birthplace is not fill, not created" do
      attach_file 'celebrity_image', "#{Rails.root}/spec/fixtures/celebrity/sample_icon.jpeg"
      fill_in "celebrity_name", with: build_celebrity.name
      fill_in "celebrity_ruby", with: build_celebrity.ruby
      fill_in "celebrity_date_of_birth", with: build_celebrity.date_of_birth
      fill_in "celebrity_history", with: build_celebrity.history
      click_button "作成"
      expect(page).to have_content "出身地を入力してください"
    end

    scenario "when history is not fill, not created" do
      attach_file 'celebrity_image', "#{Rails.root}/spec/fixtures/celebrity/sample_icon.jpeg"
      fill_in "celebrity_name", with: build_celebrity.name
      fill_in "celebrity_ruby", with: build_celebrity.ruby
      fill_in "celebrity_date_of_birth", with: build_celebrity.date_of_birth
      fill_in "celebrity_birthplace", with: build_celebrity.birthplace
      click_button "作成"
      expect(page).to have_content "歴史を入力してください"
    end

    scenario "when you back click the link, the account will be displayed", js: true do
      click_link "戻る"
      expect(page).to have_content "著名人 新規作成"
    end
  end

  describe "celebrity#edit" do
    describe "admin logined" do
      before do
        sign_in admin
        visit admins_path
        visit edit_celebrity_path(celebrity)
      end

      it "when displayed, the content is displayed correctly" do
        expect(page).to have_selector 'p', text: "著名人編集"
        expect(page).to have_content "著名人画像"
        expect(page).to have_content "ふりがな"
        expect(page).to have_content "名前"
        expect(page).to have_content "生年月日"
        expect(page).to have_content "出身地"
        expect(page).to have_content "歴史"
        expect(page).to have_selector "input[value='更新']"
        expect(page).to have_content "削除"
        expect(page).to have_content "戻る"
      end

      scenario "when all fill, updated" do
        attach_file 'celebrity_image', "#{Rails.root}/spec/fixtures/celebrity/sample_icon.jpeg"
        fill_in "celebrity_name", with: build_celebrity.name
        fill_in "celebrity_ruby", with: build_celebrity.ruby
        fill_in "celebrity_date_of_birth", with: build_celebrity.date_of_birth
        fill_in "celebrity_birthplace", with: build_celebrity.birthplace
        fill_in "celebrity_history", with: build_celebrity.history
        click_button "更新"
        expect(page).to have_content "著名人を更新しました"
      end

      scenario "when name is not fill, not updated" do
        fill_in "celebrity_name", with: nil
        click_button "更新"
        expect(page).to have_content "名前を入力してください"
      end

      scenario "when ruby is not fill, not updated" do
        fill_in "celebrity_ruby", with: nil
        click_button "更新"
        expect(page).to have_content "ふりがなを入力してください"
      end

      scenario "when date of birth is not fill, not updated" do
        fill_in "celebrity_date_of_birth", with: nil
        click_button "更新"
        expect(page).to have_content "生年月日を入力してください"
      end

      scenario "when birthplace is not fill, not updated" do
        fill_in "celebrity_birthplace", with: nil
        click_button "更新"
        expect(page).to have_content "出身地を入力してください"
      end

      scenario "when history is not fill, not updated" do
        fill_in "celebrity_history", with: nil
        click_button "更新"
        expect(page).to have_content "歴史を入力してください"
      end

      scenario "when you celebrity delete click the link, deleted", js: true do
        click_link "削除"
        expect(page.accept_confirm).to eq "本当に削除しますか？"
        expect(page).to have_content "著名人を削除しました"
        expect(Celebrity.exists?(id: celebrity.id)).to be false
      end

      scenario "when you back click the link, the account will be displayed", js: true do
        click_link "戻る"
        expect(page).to have_content "著名人 新規作成"
      end
    end

    describe "guest admin logined" do
      before do
        sign_in guest_admin
        visit edit_celebrity_path(celebrity)
      end

      scenario "when you celebrity delete click the link, deleted", js: true do
        click_link "削除"
        expect(page.accept_confirm).to eq "本当に削除しますか？"
        expect(page).to have_content "ゲストユーザーは削除権限がありません"
        expect(Celebrity.exists?(id: celebrity.id)).to be true
      end
    end
  end

  describe "celebrity#show" do
    before do
      sign_in user
      visit root_path
      visit celebrity_path(celebrity)
    end

    it "when displayed, the content is displayed correctly" do
      expect(page).to have_content celebrity.name
      expect(page).to have_content celebrity.ruby
      expect(page).to have_content celebrity.date_of_birth
      expect(page).to have_content celebrity.birthplace
      expect(page).to have_content celebrity.history
      expect(page).to have_content "戻る"
    end

    scenario "when you back click the link, the account will be displayed", js: true do
      click_link "戻る"
      expect(page).to have_content "著名人 詳細"
    end
  end
end
