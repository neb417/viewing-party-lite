require 'rails_helper'

RSpec.describe 'Login Page' do
  let!(:user) { create(:user) }

  describe 'happy path test' do
    it 'has login button and routing' do
      visit root_path
      expect(page).to have_button('Login')
      click_on 'Login'
      expect(current_path).to eq(login_path)
    end

    it 'has correct login information' do
      visit login_path

      expect(page).to have_field('Enter Email')
      expect(page).to have_field('Enter Password')
      expect(page).to have_button('Login')
    end

    it 'routes to correct path' do
      visit login_path

      fill_in 'Enter Email', with: user.email
      fill_in 'Enter Password', with: user.password

      click_on 'Login'

      expect(current_path).to eq(user_dashboard_path(user))
      expect(page).to have_content("Welcome #{user.name}")
    end
  end

  describe 'sad path test' do
    it 'routes to back with invalid entry path' do
      visit login_path

      fill_in 'Enter Email', with: nil
      fill_in 'Enter Password', with: user.password

      click_on 'Login'

      expect(current_path).to eq(login_path)
      expect(page).to have_content('User name and/or password is incorrect')
    end

    it 'routes to back with invalid entry path' do
      visit login_path

      fill_in 'Enter Email', with: user.email
      fill_in 'Enter Password', with: nil

      click_on 'Login'

      expect(current_path).to eq(login_path)
      expect(page).to have_content('User name and/or password is incorrect')
    end
  end
end