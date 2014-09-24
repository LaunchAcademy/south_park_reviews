module Helpers
  module Authentication
    def sign_in_as(user)
      visit new_user_session_path

      within "#new_user" do
        fill_in "Login", with: user.email
        fill_in "Password", with: user.password
        click_on "Sign in"
      end
    end
  end
end
