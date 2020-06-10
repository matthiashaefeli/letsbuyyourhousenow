require 'rails_helper'

RSpec.describe 'Login', type: :system do
  let!(:user) { FactoryBot.create(:user) }

  describe 'user login' do
    it 'successfully login a user' do
      visit new_user_session_path
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      click_on 'Log in'
      expect(page).to have_text('SignOut')
    end
  end
end