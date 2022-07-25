require 'rails_helper'

RSpec.describe "Cinema", type: :system do
  let(:admin) { create(:admin) }
  let(:guest_admin) { create(:admin, email: "guest@example.com") }
  let(:user) { create(:user, profile: profile) }
  let(:guest_user) { create(:user, email: "guest@example.com", profile: profile1) }
  let(:profile) { build(:profile) }
  let(:profile1) { build(:profile) }
  let(:cinema) { create(:cinema) }
  let(:build_cinema) { build(:cinema, title: "build_cinema_title") }

  before do
    profile.image.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'profile', 'default_icon.jpeg')), filename: 'default_icon.jpeg', content_type: 'image/jpeg')
    profile1.image.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'profile', 'default_icon.jpeg')), filename: 'default_icon.jpeg', content_type: 'image/jpeg')
    user.confirm
    guest_user.confirm
    cinema.image.attach(io: File.open(Rails.root.join('spec', 'fixtures', 'cinema', 'sample_01.png')), filename: 'sample_01.png', content_type: 'image/png')
  end

  describe "cinema#new" do
    before do
      sign_in admin
      visit admins_path
      visit new_cinema_path
    end

    it "when displayed, the content is displayed correctly" do
      expect(page).to have_selector 'p', text: "映画新規作成"
      expect(page).to have_content "映画画像"
      expect(page).to have_content "タイトル"
      expect(page).to have_content "上映時間"
      expect(page).to have_content "制作国"
      expect(page).to have_content "映画観客指定"
      expect(page).to have_content "監督"
      expect(page).to have_content "原作"
      expect(page).to have_content "出演"
      expect(page).to have_content "映画脚本家"
      expect(page).to have_content "配給"
      expect(page).to have_content "上映時間"
      expect(page).to have_content "ストーリー"
      expect(page).to have_selector "input[value='作成']"
      expect(page).to have_content "戻る"
    end

    scenario "when all fill, created" do
      attach_file 'cinema_image', "#{Rails.root}/spec/fixtures/cinema/sample_01.png"
      fill_in "cinema_title", with: build_cinema.title
      fill_in "cinema_screen_time", with: build_cinema.screen_time
      fill_in "cinema_birthplace", with: build_cinema.birthplace
      fill_in "cinema_movie_rating", with: build_cinema.movie_rating
      fill_in "cinema_director", with: build_cinema.director
      fill_in "cinema_original", with: build_cinema.original
      fill_in "cinema_appearance", with: build_cinema.appearance
      fill_in "cinema_screenwriter", with: build_cinema.screenwriter
      fill_in "cinema_distribution", with: build_cinema.distribution
      fill_in "cinema_start_date", with: build_cinema.start_date
      fill_in "cinema_story", with: build_cinema.story

      expect do
        click_button "作成"
        expect(page).to have_content "映画を作成しました"
      end.to change(Cinema, :count).by(1)
    end

    scenario "when title is not fill, not created" do
      attach_file 'cinema_image', "#{Rails.root}/spec/fixtures/cinema/sample_01.png"
      fill_in "cinema_screen_time", with: build_cinema.screen_time
      fill_in "cinema_birthplace", with: build_cinema.birthplace
      fill_in "cinema_movie_rating", with: build_cinema.movie_rating
      fill_in "cinema_director", with: build_cinema.director
      fill_in "cinema_original", with: build_cinema.original
      fill_in "cinema_appearance", with: build_cinema.appearance
      fill_in "cinema_screenwriter", with: build_cinema.screenwriter
      fill_in "cinema_distribution", with: build_cinema.distribution
      fill_in "cinema_start_date", with: build_cinema.start_date
      fill_in "cinema_story", with: build_cinema.story
      click_button "作成"
      expect(page).to have_content "タイトルを入力してください"
    end

    scenario "when screen time is not fill, not created" do
      attach_file 'cinema_image', "#{Rails.root}/spec/fixtures/cinema/sample_01.png"
      fill_in "cinema_title", with: build_cinema.title
      fill_in "cinema_birthplace", with: build_cinema.birthplace
      fill_in "cinema_movie_rating", with: build_cinema.movie_rating
      fill_in "cinema_director", with: build_cinema.director
      fill_in "cinema_original", with: build_cinema.original
      fill_in "cinema_appearance", with: build_cinema.appearance
      fill_in "cinema_screenwriter", with: build_cinema.screenwriter
      fill_in "cinema_distribution", with: build_cinema.distribution
      fill_in "cinema_start_date", with: build_cinema.start_date
      fill_in "cinema_story", with: build_cinema.story
      click_button "作成"
      expect(page).to have_content "上映時間を入力してください"
    end

    scenario "when birthplace is not fill, not created" do
      attach_file 'cinema_image', "#{Rails.root}/spec/fixtures/cinema/sample_01.png"
      fill_in "cinema_title", with: build_cinema.title
      fill_in "cinema_screen_time", with: build_cinema.screen_time
      fill_in "cinema_movie_rating", with: build_cinema.movie_rating
      fill_in "cinema_director", with: build_cinema.director
      fill_in "cinema_original", with: build_cinema.original
      fill_in "cinema_appearance", with: build_cinema.appearance
      fill_in "cinema_screenwriter", with: build_cinema.screenwriter
      fill_in "cinema_distribution", with: build_cinema.distribution
      fill_in "cinema_start_date", with: build_cinema.start_date
      fill_in "cinema_story", with: build_cinema.story
      click_button "作成"
      expect(page).to have_content "制作国を入力してください"
    end

    scenario "when movie rating is not fill, not created" do
      attach_file 'cinema_image', "#{Rails.root}/spec/fixtures/cinema/sample_01.png"
      fill_in "cinema_title", with: build_cinema.title
      fill_in "cinema_screen_time", with: build_cinema.screen_time
      fill_in "cinema_birthplace", with: build_cinema.birthplace
      fill_in "cinema_director", with: build_cinema.director
      fill_in "cinema_original", with: build_cinema.original
      fill_in "cinema_appearance", with: build_cinema.appearance
      fill_in "cinema_screenwriter", with: build_cinema.screenwriter
      fill_in "cinema_distribution", with: build_cinema.distribution
      fill_in "cinema_start_date", with: build_cinema.start_date
      fill_in "cinema_story", with: build_cinema.story
      click_button "作成"
      expect(page).to have_content "映画観客指定を入力してくださ"
    end

    scenario "when director is not fill, not created" do
      attach_file 'cinema_image', "#{Rails.root}/spec/fixtures/cinema/sample_01.png"
      fill_in "cinema_title", with: build_cinema.title
      fill_in "cinema_screen_time", with: build_cinema.screen_time
      fill_in "cinema_birthplace", with: build_cinema.birthplace
      fill_in "cinema_movie_rating", with: build_cinema.movie_rating
      fill_in "cinema_original", with: build_cinema.original
      fill_in "cinema_appearance", with: build_cinema.appearance
      fill_in "cinema_screenwriter", with: build_cinema.screenwriter
      fill_in "cinema_distribution", with: build_cinema.distribution
      fill_in "cinema_start_date", with: build_cinema.start_date
      fill_in "cinema_story", with: build_cinema.story
      click_button "作成"
      expect(page).to have_content "監督を入力してください"
    end

    scenario "when original is not fill, not created" do
      attach_file 'cinema_image', "#{Rails.root}/spec/fixtures/cinema/sample_01.png"
      fill_in "cinema_title", with: build_cinema.title
      fill_in "cinema_screen_time", with: build_cinema.screen_time
      fill_in "cinema_birthplace", with: build_cinema.birthplace
      fill_in "cinema_movie_rating", with: build_cinema.movie_rating
      fill_in "cinema_director", with: build_cinema.director
      fill_in "cinema_appearance", with: build_cinema.appearance
      fill_in "cinema_screenwriter", with: build_cinema.screenwriter
      fill_in "cinema_distribution", with: build_cinema.distribution
      fill_in "cinema_start_date", with: build_cinema.start_date
      fill_in "cinema_story", with: build_cinema.story
      click_button "作成"
      expect(page).to have_content "原作を入力してください"
    end

    scenario "when appearance is not fill, not created" do
      attach_file 'cinema_image', "#{Rails.root}/spec/fixtures/cinema/sample_01.png"
      fill_in "cinema_title", with: build_cinema.title
      fill_in "cinema_screen_time", with: build_cinema.screen_time
      fill_in "cinema_birthplace", with: build_cinema.birthplace
      fill_in "cinema_movie_rating", with: build_cinema.movie_rating
      fill_in "cinema_director", with: build_cinema.director
      fill_in "cinema_original", with: build_cinema.original
      fill_in "cinema_screenwriter", with: build_cinema.screenwriter
      fill_in "cinema_distribution", with: build_cinema.distribution
      fill_in "cinema_start_date", with: build_cinema.start_date
      fill_in "cinema_story", with: build_cinema.story
      click_button "作成"
      expect(page).to have_content "出演を入力してください"
    end

    scenario "when screenwriter is not fill, not created" do
      attach_file 'cinema_image', "#{Rails.root}/spec/fixtures/cinema/sample_01.png"
      fill_in "cinema_title", with: build_cinema.title
      fill_in "cinema_screen_time", with: build_cinema.screen_time
      fill_in "cinema_birthplace", with: build_cinema.birthplace
      fill_in "cinema_movie_rating", with: build_cinema.movie_rating
      fill_in "cinema_director", with: build_cinema.director
      fill_in "cinema_original", with: build_cinema.original
      fill_in "cinema_appearance", with: build_cinema.appearance
      fill_in "cinema_distribution", with: build_cinema.distribution
      fill_in "cinema_start_date", with: build_cinema.start_date
      fill_in "cinema_story", with: build_cinema.story
      click_button "作成"
      expect(page).to have_content "映画脚本家を入力してください"
    end

    scenario "when distribution is not fill, not created" do
      attach_file 'cinema_image', "#{Rails.root}/spec/fixtures/cinema/sample_01.png"
      fill_in "cinema_title", with: build_cinema.title
      fill_in "cinema_screen_time", with: build_cinema.screen_time
      fill_in "cinema_birthplace", with: build_cinema.birthplace
      fill_in "cinema_movie_rating", with: build_cinema.movie_rating
      fill_in "cinema_director", with: build_cinema.director
      fill_in "cinema_original", with: build_cinema.original
      fill_in "cinema_appearance", with: build_cinema.appearance
      fill_in "cinema_screenwriter", with: build_cinema.screenwriter
      fill_in "cinema_start_date", with: build_cinema.start_date
      fill_in "cinema_story", with: build_cinema.story
      click_button "作成"
      expect(page).to have_content "配給を入力してください"
    end

    scenario "when start date is not fill, not created" do
      attach_file 'cinema_image', "#{Rails.root}/spec/fixtures/cinema/sample_01.png"
      fill_in "cinema_title", with: build_cinema.title
      fill_in "cinema_screen_time", with: build_cinema.screen_time
      fill_in "cinema_birthplace", with: build_cinema.birthplace
      fill_in "cinema_movie_rating", with: build_cinema.movie_rating
      fill_in "cinema_director", with: build_cinema.director
      fill_in "cinema_original", with: build_cinema.original
      fill_in "cinema_appearance", with: build_cinema.appearance
      fill_in "cinema_screenwriter", with: build_cinema.screenwriter
      fill_in "cinema_distribution", with: build_cinema.distribution
      fill_in "cinema_story", with: build_cinema.story
      click_button "作成"
      expect(page).to have_content "上映開始日を入力してください"
    end

    scenario "when story is not fill, not created" do
      attach_file 'cinema_image', "#{Rails.root}/spec/fixtures/cinema/sample_01.png"
      fill_in "cinema_title", with: build_cinema.title
      fill_in "cinema_screen_time", with: build_cinema.screen_time
      fill_in "cinema_birthplace", with: build_cinema.birthplace
      fill_in "cinema_movie_rating", with: build_cinema.movie_rating
      fill_in "cinema_director", with: build_cinema.director
      fill_in "cinema_original", with: build_cinema.original
      fill_in "cinema_appearance", with: build_cinema.appearance
      fill_in "cinema_screenwriter", with: build_cinema.screenwriter
      fill_in "cinema_distribution", with: build_cinema.distribution
      fill_in "cinema_start_date", with: build_cinema.start_date
      click_button "作成"
      expect(page).to have_content "ストーリーを入力してください"
    end

    scenario "when you back click the link, will be displayed", js: true do
      click_link "戻る"
      expect(page).to have_content "映画 新規作成"
    end
  end

  describe "celebrity#edit" do
    describe "admin logined" do
      before do
        sign_in admin
        visit admins_path
        visit edit_cinema_path(cinema)
      end

      it "when displayed, the content is displayed correctly" do
        expect(page).to have_selector 'p', text: "映画編集"
        expect(page).to have_content "映画画像"
        expect(page).to have_content "タイトル"
        expect(page).to have_content "上映時間"
        expect(page).to have_content "制作国"
        expect(page).to have_content "映画観客指定"
        expect(page).to have_content "監督"
        expect(page).to have_content "原作"
        expect(page).to have_content "出演"
        expect(page).to have_content "映画脚本家"
        expect(page).to have_content "配給"
        expect(page).to have_content "上映時間"
        expect(page).to have_content "ストーリー"
        expect(page).to have_selector "input[value='更新']"
        expect(page).to have_content "戻る"
      end

      scenario "when all fill, updated" do
        attach_file 'cinema_image', "#{Rails.root}/spec/fixtures/cinema/sample_01.png"
        fill_in "cinema_title", with: build_cinema.title
        fill_in "cinema_screen_time", with: build_cinema.screen_time
        fill_in "cinema_birthplace", with: build_cinema.birthplace
        fill_in "cinema_movie_rating", with: build_cinema.movie_rating
        fill_in "cinema_director", with: build_cinema.director
        fill_in "cinema_original", with: build_cinema.original
        fill_in "cinema_appearance", with: build_cinema.appearance
        fill_in "cinema_screenwriter", with: build_cinema.screenwriter
        fill_in "cinema_distribution", with: build_cinema.distribution
        fill_in "cinema_start_date", with: build_cinema.start_date
        fill_in "cinema_story", with: build_cinema.story
        click_button "更新"
        expect(page).to have_content "映画を更新しました"
      end

      scenario "when title is not fill, not updated" do
        fill_in "cinema_title", with: nil
        click_button "更新"
        expect(page).to have_content "タイトルを入力してください"
      end

      scenario "when screen time is not fill, not updated" do
        fill_in "cinema_screen_time", with: nil
        click_button "更新"
        expect(page).to have_content "上映時間を入力してください"
      end

      scenario "when birthplace is not fill, not updated" do
        fill_in "cinema_birthplace", with: nil
        click_button "更新"
        expect(page).to have_content "制作国を入力してください"
      end

      scenario "when movie rating is not fill, not updated" do
        fill_in "cinema_movie_rating", with: nil
        click_button "更新"
        expect(page).to have_content "映画観客指定を入力してくださ"
      end

      scenario "when director is not fill, not updated" do
        fill_in "cinema_director", with: nil
        click_button "更新"
        expect(page).to have_content "監督を入力してください"
      end

      scenario "when original is not fill, not updated" do
        fill_in "cinema_original", with: nil
        click_button "更新"
        expect(page).to have_content "原作を入力してください"
      end

      scenario "when appearance is not fill, not updated" do
        fill_in "cinema_appearance", with: nil
        click_button "更新"
        expect(page).to have_content "出演を入力してください"
      end

      scenario "when screenwriter is not fill, not updated" do
        fill_in "cinema_screenwriter", with: nil
        click_button "更新"
        expect(page).to have_content "映画脚本家を入力してください"
      end

      scenario "when distribution is not fill, not updated" do
        fill_in "cinema_distribution", with: nil
        click_button "更新"
        expect(page).to have_content "配給を入力してください"
      end

      scenario "when start date is not fill, not updated" do
        fill_in "cinema_start_date", with: nil
        click_button "更新"
        expect(page).to have_content "上映開始日を入力してください"
      end

      scenario "when story is not fill, not updated" do
        fill_in "cinema_story", with: nil
        click_button "更新"
        expect(page).to have_content "ストーリーを入力してください"
      end

      scenario "when you cinema delete click the link, deleted", js: true do
        click_link "削除"
        expect(page.accept_confirm).to eq "本当に削除しますか？"
        expect(page).to have_content "映画を削除しました"
        expect(Cinema.exists?(id: cinema.id)).to be false
      end

      scenario "when you back click the link, will be displayed", js: true do
        click_link "戻る"
        expect(page).to have_content "映画 編集"
      end
    end

    describe "guest admin logined" do
      before do
        sign_in guest_admin
        visit edit_cinema_path(cinema)
      end

      scenario "when you cinema delete click the link, deleted", js: true do
        click_link "削除"
        expect(page.accept_confirm).to eq "本当に削除しますか？"
        expect(page).to have_content "ゲストユーザーは削除権限がありません"
        expect(Cinema.exists?(id: cinema.id)).to be true
      end
    end
  end
end
