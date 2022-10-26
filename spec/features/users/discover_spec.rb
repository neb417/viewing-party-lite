require 'rails_helper' 

RSpec.describe 'Discover Movies page' do
  let!(:users) { create_list(:user, 3) }
  let!(:user1) { users.first }

  before :each do
    visit login_path

    fill_in 'Enter Email', with: user1.email
    fill_in 'Enter Password', with: user1.password
    click_on 'Login'
  end

  it 'link directs to the discover page' do
    click_on 'Discover Movies'

    expect(current_path).to eq(discover_path)
  end

  it 'link directs to the discover page' do
    visit discover_path

    expect(page).to have_content("Discover Movies")
  end

  it 'has button for top rated movies' do
    visit discover_path

    expect(page).to have_button('Find Top Rated Movies')

    click_on 'Find Top Rated Movies'

    expect(current_path).to eq(movies_path)
  end

  it 'has text field to search for movies' do
    visit discover_path

    expect(page).to have_button('Find Movies')

    fill_in :q, with: 'Wayne'

    click_on 'Find Movies'

    expect(current_path).to eq(movies_path)
  end
end