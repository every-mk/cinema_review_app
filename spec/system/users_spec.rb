require 'rails_helper'

RSpec.describe "Users", type: :system do
  let(:user) { create(:user, profile: profile) }
  let(:build_user) { build(:user, email: "build_user@gmail.com", profile: profile1) }
  let(:guest_user) { create(:user, email: "guest@example.com", profile: profile2) }
  let(:profile) { build(:profile) }
  let(:profile1) { build(:profile) }
  let(:profile2) { build(:profile) }

  before do
    profile.image.attach(io: File.open(Rails.root.join('spec', 'fixtures', 'profile', 'sample_icon.jpeg')), filename: 'default_icon.jpeg', content_type: 'image/jpeg')
    profile2.image.attach(io: File.open(Rails.root.join('spec', 'fixtures', 'profile', 'sample_icon.jpeg')), filename: 'default_icon.jpeg', content_type: 'image/jpeg')
    user.confirm
    guest_user.confirm
  end

  describe "#sign_up" do
    before do
      visit new_user_registration_path
    end

    it "when displayed, the header is displayed correctly" do
      expect(page).to have_selector "img[alt=サイトのロゴ画像]"
      # ToDo: サイトのログ画像URLを追加する.
      expect(page).to have_content "ログイン"
      expect(page).to have_content "登録する"
    end

    it "when displayed, the content is displayed correctly" do
      expect(page).to have_selector 'p', text: "新しいアカウントを作成"
      expect(page).to have_content "名前"
      expect(page).to have_content "性別"
      expect(page).to have_content "男性"
      expect(page).to have_content "女性"
      expect(page).to have_content "生年月日"
      expect(page).to have_content "都道府県"
      expect(page).to have_content "Eメール"
      expect(page).to have_content "新しいアカウントを作成"
      expect(page).to have_selector "input[value='新しいアカウントを作成']"
      expect(page).to have_content "パスワード"
      expect(page).to have_content "パスワード（確認用）"
      expect(page).to have_content "既にアカウントをお持ちの方はログイン"
      expect(page).to have_content "認証確認メールが届かない場合"
    end

    it "when displayed, the footer is displayed correctly" do
      expect(page).to have_content "©︎ 2022 S.K"
    end

    scenario "when all fill, created account" do
      fill_in "profile_name", with: profile.name
      choose "女性"
      fill_in "profile_date_of_birth", with: profile.date_of_birth
      fill_in "profile_prefecture", with: profile.prefecture
      fill_in "profile_municipality", with: profile.municipality
      fill_in "user_email", with: "build_user1@gmail.com"
      fill_in "user_password", with: build_user.password
      fill_in "user_password_confirmation", with: build_user.password_confirmation

      expect do
        click_button "新しいアカウントを作成"
        expect(page).to have_content "本人確認用のメールを送信しました。メール内のリンクからアカウントを有効化させてください。"
      end.to change(User, :count).by(1)
    end

    scenario "when name is not fill, not created account" do
      choose "女性"
      fill_in "profile_date_of_birth", with: profile.date_of_birth
      fill_in "profile_prefecture", with: profile.prefecture
      fill_in "profile_municipality", with: profile.municipality
      fill_in "user_email", with: "build_user1@gmail.com"
      fill_in "user_password", with: build_user.password
      fill_in "user_password_confirmation", with: build_user.password_confirmation
      click_button "新しいアカウントを作成"
      expect(page).to have_content "名前を入力してください"
    end

    scenario "when date of birth is not fill, not created account" do
      fill_in "profile_name", with: profile.name
      choose "女性"
      fill_in "profile_prefecture", with: profile.prefecture
      fill_in "profile_municipality", with: profile.municipality
      fill_in "user_email", with: "build_user1@gmail.com"
      fill_in "user_password", with: build_user.password
      fill_in "user_password_confirmation", with: build_user.password_confirmation
      click_button "新しいアカウントを作成"
      expect(page).to have_content "生年月日を入力してください"
    end

    scenario "when prefecture is fill, not created account" do
      fill_in "profile_name", with: profile.name
      choose "女性"
      fill_in "profile_date_of_birth", with: profile.date_of_birth
      fill_in "profile_municipality", with: profile.municipality
      fill_in "user_email", with: "build_user1@gmail.com"
      fill_in "user_password", with: build_user.password
      fill_in "user_password_confirmation", with: build_user.password_confirmation
      click_button "新しいアカウントを作成"
      expect(page).to have_content "都道府県を入力してください"
    end

    scenario "when municipality is fill, not created account" do
      fill_in "profile_name", with: profile.name
      choose "女性"
      fill_in "profile_date_of_birth", with: profile.date_of_birth
      fill_in "profile_prefecture", with: profile.prefecture
      fill_in "user_email", with: "build_user1@gmail.com"
      fill_in "user_password", with: build_user.password
      fill_in "user_password_confirmation", with: build_user.password_confirmation
      click_button "新しいアカウントを作成"
      expect(page).to have_content "市区町村を入力してください"
    end

    scenario "when email is fill, not created account" do
      fill_in "profile_name", with: profile.name
      choose "女性"
      fill_in "profile_date_of_birth", with: profile.date_of_birth
      fill_in "profile_prefecture", with: profile.prefecture
      fill_in "profile_municipality", with: profile.municipality
      fill_in "user_password", with: build_user.password
      fill_in "user_password_confirmation", with: build_user.password_confirmation
      click_button "新しいアカウントを作成"
      expect(page).to have_content "Eメールを入力してください"
    end

    scenario "when password is fill, not created account" do
      fill_in "profile_name", with: profile.name
      choose "女性"
      fill_in "profile_date_of_birth", with: profile.date_of_birth
      fill_in "profile_prefecture", with: profile.prefecture
      fill_in "profile_municipality", with: profile.municipality
      fill_in "user_email", with: "build_user1@gmail.com"
      fill_in "user_password_confirmation", with: build_user.password_confirmation
      click_button "新しいアカウントを作成"
      expect(page).to have_content "パスワードを入力してください"
    end

    scenario "when password confirmation is fill, not created account" do
      fill_in "profile_name", with: profile.name
      choose "女性"
      fill_in "profile_date_of_birth", with: profile.date_of_birth
      fill_in "profile_prefecture", with: profile.prefecture
      fill_in "profile_municipality", with: profile.municipality
      fill_in "user_email", with: "build_user1@gmail.com"
      fill_in "user_password", with: build_user.password
      click_button "新しいアカウントを作成"
      expect(page).to have_content "パスワード（確認用）とパスワードの入力が一致しません"
    end

    scenario "when you login click the link, login will be displayed" do
      click_link "既にアカウントをお持ちの方はログイン"
      expect(page).to have_selector 'p', text: "ログイン"
    end

    scenario "when you resend authentication confirmation email click the link, resend authentication confirmation email will be displayed" do
      click_link "認証確認メールが届かない場合"
      expect(page).to have_selector 'p', text: "認証確認メールが届かない場合"
    end
  end

  describe "password#new" do
    before do
      visit new_user_password_path
    end

    it "when displayed, the content is displayed correctly" do
      expect(page).to have_selector 'p', text: "パスワードを忘れた場合"
      expect(page).to have_content "Eメール"
      expect(page).to have_selector "input[value='パスワード再設定メールを送信する']"
      expect(page).to have_content "既にアカウントをお持ちの方はログイン"
      expect(page).to have_content "新しいアカウントを作成"
      expect(page).to have_content "認証確認メールが届かない場合"
    end

    scenario "when email is not wrong, email is send" do
      fill_in "user_email", with: user.email
      click_button "パスワード再設定メールを送信する"
      expect(page).to have_content "パスワードの再設定について数分以内にメールでご連絡いたします。"
    end

    scenario "when email is not fill, email is not send" do
      click_button "パスワード再設定メールを送信する"
      expect(page).to have_content "Eメールを入力してください"
    end

    scenario "when email is wrong, email is not send" do
      fill_in "user_email", with: "wrong_email@gmail.com"
      click_button "パスワード再設定メールを送信する"
      expect(page).to have_content "Eメールは見つかりませんでした。"
    end

    scenario "when you login click the link, login will be displayed" do
      click_link "既にアカウントをお持ちの方はログイン"
      expect(page).to have_selector 'p', text: "ログイン"
    end

    scenario "when you new account click the link, sign up will be displayed" do
      click_link "新しいアカウントを作成"
      expect(page).to have_selector 'p', text: "新しいアカウントを作成"
    end

    scenario "when you resend authentication confirmation email click the link, resend authentication confirmation email will be displayed" do
      click_link "認証確認メールが届かない場合"
      expect(page).to have_selector 'p', text: "認証確認メールが届かない場合"
    end
  end

  describe "confirmation#new" do
    before do
      visit new_user_confirmation_path
    end

    it "when displayed, the content is displayed correctly" do
      expect(page).to have_selector 'p', text: "認証確認メールが届かない場合"
      expect(page).to have_content "Eメール"
      expect(page).to have_selector "input[value='認証確認メールを再送する']"
      expect(page).to have_content "既にアカウントをお持ちの方はログイン"
      expect(page).to have_content "新しいアカウントを作成"
      expect(page).to have_content "パスワードを忘れた場合"
    end

    scenario "if account has been verified, no email will be sent." do
      fill_in "user_email", with: user.email
      click_button "認証確認メールを再送する"
      expect(page).to have_content "Eメールは既に登録済みです。ログインしてください。"
    end

    scenario "if account has been not verified, email will be sent." do
      build_user.save
      fill_in "user_email", with: build_user.email
      click_button "認証確認メールを再送する"
      expect(page).to have_content "アカウントの有効化について数分以内にメールでご連絡します。"
    end

    scenario "when email is not fill, email is not send" do
      click_button "認証確認メールを再送する"
      expect(page).to have_content "Eメールを入力してください"
    end

    scenario "when email is wrong, email is not send" do
      fill_in "user_email", with: "wrong_email@gmail.com"
      click_button "認証確認メールを再送する"
      expect(page).to have_content "Eメールは見つかりませんでした。"
    end

    scenario "when you login click the link, login will be displayed" do
      click_link "既にアカウントをお持ちの方はログイン"
      expect(page).to have_selector 'p', text: "ログイン"
    end

    scenario "when you new account click the link, sign up will be displayed" do
      click_link "新しいアカウントを作成"
      expect(page).to have_selector 'p', text: "新しいアカウントを作成"
    end

    scenario "when forget password click the link, login will be displayed" do
      click_link "パスワードを忘れた場合"
      expect(page).to have_selector 'p', text: "パスワードを忘れた場合"
    end
  end

  describe "#sign_in" do
    before do
      visit new_user_session_path
    end

    it "when displayed, the content is displayed correctly" do
      expect(page).to have_selector 'p', text: "ログイン"
      expect(page).to have_content "Eメール"
      expect(page).to have_content "パスワード"
      expect(page).to have_selector "input[value='ログイン']"
      expect(page).to have_content "ゲストログイン"
      expect(page).to have_content "新しいアカウントを作成"
      expect(page).to have_content "パスワードを忘れた場合"
      expect(page).to have_content "認証確認メールが届かない場合"
    end

    scenario "when all fill, logined" do
      fill_in "user_email", with: user.email
      fill_in "user_password", with: build_user.password
      click_button "ログイン"
      expect(page).to have_content "ログインしました。"
    end

    scenario "when email is not fill, not logined" do
      fill_in "user_password", with: build_user.password
      click_button "ログイン"
      expect(page).to have_content "Eメールまたはパスワードが違います。"
    end

    scenario "when password is not fill, not logined" do
      fill_in "user_email", with: user.email
      click_button "ログイン"
      expect(page).to have_content "Eメールまたはパスワードが違います。"
    end

    scenario "when password is wrong, not logined" do
      fill_in "user_email", with: user.email
      fill_in "user_password", with: "wrong_password"
      click_button "ログイン"
      expect(page).to have_content "Eメールまたはパスワードが違います。"
    end

    scenario "when you guest login click the link, logined" do
      click_link "ゲストログイン"
      expect(page).to have_content "ログインしました。"
    end

    scenario "when you new account click the link, sign up will be displayed" do
      click_link "新しいアカウントを作成"
      expect(page).to have_selector 'p', text: "新しいアカウントを作成"
    end

    scenario "when forget password click the link, login will be displayed" do
      click_link "パスワードを忘れた場合"
      expect(page).to have_selector 'p', text: "パスワードを忘れた場合"
    end

    scenario "when you resend authentication confirmation email click the link, resend authentication confirmation email will be displayed" do
      click_link "認証確認メールが届かない場合"
      expect(page).to have_selector 'p', text: "認証確認メールが届かない場合"
    end
  end

  describe "#account" do
    describe "user logined" do
      before do
        sign_in user
        visit users_account_path
      end

      it "when displayed, the content is displayed correctly" do
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

      scenario "when you pc version account click the link, the account information will be displayed" do
        find("div[class='user-nav user-nav-pc']").click_on "アカウント"
        expect(page).to have_selector 'p', text: "アカウント"
      end

      scenario "when you mobile version account click the link, the account information will be displayed" do
        find("div[class='user-nav user-nav-mobile']").click_on "アカウント"
        expect(page).to have_selector 'p', text: "アカウント"
      end

      scenario "when you pc version profile click the link, the profile information will be displayed" do
        find("div[class='user-nav user-nav-pc']").click_on "プロファイル"
        expect(page).to have_selector 'p', text: "プロファイル"
      end

      scenario "when you mobile version profile click the link, the profile information will be displayed" do
        find("div[class='user-nav user-nav-mobile']").click_on "プロファイル"
        expect(page).to have_selector 'p', text: "プロファイル"
      end

      scenario "when you edit click the link, the account edit will be displayed" do
        click_link "編集"
        expect(page).to have_selector 'h1', text: "アカウント編集"
      end

      scenario "when you account delete click the link, account deleted", js: true do
        click_link "アカウント削除"
        expect(page.accept_confirm).to eq "本当に削除しますか？"
        expect(page).to have_content "アカウントを削除しました"
        expect(User.exists?(id: user.id)).to be false
      end
    end

    describe "guest user logined" do
      before do
        sign_in guest_user
        visit users_account_path
      end

      scenario "when you account delete click the link, account not deleted", js: true do
        click_link "アカウント削除"
        expect(page.accept_confirm).to eq "本当に削除しますか？"
        expect(page).to have_content "ゲストユーザーは削除できません"
        expect(User.exists?(id: user.id)).to be true
      end
    end
  end

  describe "users#edit" do
    before do
      sign_in user
      visit edit_user_registration_path
    end

    it "when displayed, the content is displayed correctly" do
      expect(page).to have_selector 'li', text: "設定"
      expect(page).to have_selector 'li', text: "ログアウト"
      expect(page).to have_selector 'h1', text: "アカウント編集"
      expect(page).to have_content "メールアドレス"
      expect(page).to have_content "変更後パスワード（変更する場合のみ入力）"
      expect(page).to have_content "スワード確認用（変更する場合のみ入力）"
      expect(page).to have_content "現在のパスワード"
      expect(page).to have_selector "input[value='更新']"
      expect(page).to have_content "戻る"
    end

    scenario "when all fill, updated" do
      fill_in "user_email", with: "update_email@gmail.com"
      fill_in "user_password", with: "update_password"
      fill_in "user_password_confirmation", with: "update_password"
      fill_in "user_current_password", with: user.password
      click_button "更新"
      expect(page).to have_content "アカウント情報を変更しました。変更されたメールアドレスの本人確認のため、本人確認用メールより確認処理をおこなってください。"
    end

    scenario "when password is not fill, not updated" do
      fill_in "user_email", with: user.email
      fill_in "user_current_password", with: user.password
      click_button "更新"
      expect(page).to have_content "アカウント情報を変更しました。"
    end

    scenario "when email is not fill, not updated" do
      fill_in "user_email", with: "update_email@gmail.com"
      fill_in "user_current_password", with: user.password
      click_button "更新"
      expect(page).to have_content "アカウント情報を変更しました。"
    end

    scenario "when password is fill, not updated" do
      fill_in "user_password_confirmation", with: "update_password"
      click_button "更新"
      expect(page).to have_content "パスワード（確認用）とパスワードの入力が一致しません"
    end

    scenario "when password confirmation is fill, not updated" do
      fill_in "user_password", with: "update_password"
      click_button "更新"
      expect(page).to have_content "パスワード（確認用）とパスワードの入力が一致しません"
    end

    scenario "when change password is wrong, not updated" do
      fill_in "user_password", with: "update_password"
      fill_in "user_password_confirmation", with: "update_wrong_password"
      click_button "更新"
      expect(page).to have_content "パスワード（確認用）とパスワードの入力が一致しません"
    end

    scenario "when you back click the link, the account will be displayed" do
      click_link "戻る"
      expect(page).to have_content "アカウント"
    end
  end

  describe "profile#show" do
    describe "user logined" do
      before do
        sign_in user
        visit profile_path
      end

      it "when displayed, the content is displayed correctly" do
        expect(page).to have_selector 'p', text: "プロファイル"
        expect(page).to have_content "アイコン画像"
        expect(page).to have_content "名前"
        expect(page).to have_content "性別"
        expect(page).to have_content "男性"
        expect(page).to have_content "女性"
        expect(page).to have_content "生年月日"
        expect(page).to have_content "都道府県"
        expect(page).to have_content "市区町村"
        expect(page).to have_selector "input[value='更新']"
        expect(page).to have_content "戻る"
      end

      scenario "when all fill, updated" do
        attach_file 'profile_image', "#{Rails.root}/spec/fixtures/profile/sample_icon.jpeg"
        fill_in "profile_name", with: "update_name"
        choose "女性"
        fill_in "profile_date_of_birth", with: "2022/01/01"
        fill_in "profile_prefecture", with: "北海道"
        fill_in "profile_municipality", with: "札幌市"
        click_button "更新"
        expect(page).to have_content "プロファイル更新しました"
      end

      scenario "when icon is not fill, not created account" do
        fill_in "profile_name", with: "update_name"
        choose "女性"
        fill_in "profile_date_of_birth", with: "2022/01/01"
        fill_in "profile_prefecture", with: "北海道"
        fill_in "profile_municipality", with: "札幌市"
        click_button "更新"
        expect(page).to have_content "プロファイル更新しました"
      end

      scenario "when you back click the link, the account will be displayed" do
        click_link "戻る"
        expect(page).to have_content "アカウント"
      end
    end
  end

  describe "guest user logined" do
    before do
      sign_in guest_user
      visit profile_path
    end

    scenario "when all fill, not updated" do
      attach_file 'profile_image', "#{Rails.root}/spec/fixtures/profile/sample_icon.jpeg"
      fill_in "profile_name", with: "update_name"
      choose "女性"
      fill_in "profile_date_of_birth", with: "2022/01/01"
      fill_in "profile_prefecture", with: "北海道"
      fill_in "profile_municipality", with: "札幌市"
      click_button "更新"
      expect(page).to have_content "ゲストユーザーはプロファイルを編集できません"
    end
  end
end
