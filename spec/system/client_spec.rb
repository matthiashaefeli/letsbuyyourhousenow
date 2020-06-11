require 'rails_helper'

RSpec.describe 'Client', type: :system do
  describe 'create new client' do

    before(:each) do
      login_as(FactoryBot.create(:user))
    end

    it 'user creates new client successfully with email' do
      visit clients_path
      click_on 'Add New Client'
      fill_in 'client_first_name', with: 'myfirstname'
      fill_in 'client_last_name', with: 'mylastname'
      fill_in 'client_email', with: 't@t.com'
      click_on 'Save'
      expect(page).to have_text('The new Client was added!')
    end

    it 'user creates new client successfully with tel' do
      visit clients_path
      click_on 'Add New Client'
      fill_in 'client_first_name', with: 'myfirstname'
      fill_in 'client_last_name', with: 'mylastname'
      fill_in 'client_tel', with: '123456789'
      click_on 'Save'
      expect(page).to have_text('The new Client was added!')
    end
  end

  describe 'cant create new client' do

    before(:each) do
      login_as(FactoryBot.create(:user))
    end

    it 'missing first name' do
      visit clients_path
      click_on 'Add New Client'
      click_on 'Save'
      expect(page.find(:css, '#client_first_name')[:style]).to eq('background-color: yellow;')
    end

    it 'missing last name' do
      visit clients_path
      click_on 'Add New Client'
      fill_in 'client_first_name', with: 'myfirstname'
      click_on 'Save'
      expect(page.find(:css, '#client_last_name')[:style]).to eq('background-color: yellow;')
    end

    it 'missing tel and email name' do
      visit clients_path
      click_on 'Add New Client'
      fill_in 'client_first_name', with: 'myfirstname'
      fill_in 'client_last_name', with: 'mylastname'
      click_on 'Save'
      expect(page.find(:css, '#client_email')[:style]).to eq('background-color: yellow;')
      expect(page.find(:css, '#client_tel')[:style]).to eq('background-color: yellow;')
    end
  end
end