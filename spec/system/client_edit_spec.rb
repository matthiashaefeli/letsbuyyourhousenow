require 'rails_helper'

RSpec.describe 'Client edit', type: :system do
  let!(:client) { FactoryBot.create(:client) }
  describe 'change status' do
    before(:each) do
      login_as(FactoryBot.create(:user))
    end

    it 'change status of client' do
      visit clients_path
      click_on client.first_name
      expect(page).to have_text('Name: ' + client.first_name + ' ' + client.last_name)
      click_on 'Edit Client'
      select 'On Hold', from: 'Status'
      click_on 'Save'
      visit clients_path
      select 'On Hold', from: 'clientFilter'
      expect(page).to have_text(client.first_name)
    end
  end
end