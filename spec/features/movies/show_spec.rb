require 'rails_helper'

RSpec.describe 'Movie Show Page' do
  let!(:users) { create_list(:user, 3) }
  let!(:user1) { users.first }

  before :each do
    visit login_path

    fill_in 'Enter Email', with: user1.email
    fill_in 'Enter Password', with: user1.password
    click_on 'Login'
  end

  it 'has a links to movie details', :vcr do
    visit discover_path

    click_on 'Find Top Rated Movies'
    click_on 'The Godfather'

    expect(current_path).to eq(movie_path(238))
    expect(page).to have_content('The Godfather')
    expect(page).to have_button('Discover Page')
  end

  it 'links to discover page', :vcr do
    visit movie_path(238)

    click_on 'Discover Page'

    expect(current_path).to eq(discover_path)
  end

  it 'displays header info', :vcr do
    visit movie_path(238)

    within("#header_info") do
      expect(page).to have_content('Vote Average: 8.7')
      expect(page).to have_content('Runtime: 2 hr 55 min')
      expect(page).to have_content('Genre(s): Drama and Crime')
    end
  end

  it 'displays a summary', :vcr do
    visit movie_path(238)

    within("#summary") do
      expect(page).to have_content('When organized crime family patriarch')
    end
  end

  it 'displays the cast', :vcr do
    visit movie_path(238)

    within("#cast") do
      expect(page).to have_content('Marlon Brando as Don Vito Corleone')
      expect(page).to have_content("Al Lettieri as Virgil 'The Turk' Sollozzo")
    end
  end

  it 'displays reviews', :vcr do
    visit movie_path(238)

    within("#reviews") do
      expect(page).to have_content('2 Review(s)')
      expect(page).to have_content('Author: ')
    end
  end

  it 'has button to create a viewing party', :vcr do
    visit movie_path(238)

    expect(page).to have_button('Create Viewing Party for The Godfather')
  end

  it 'viewing party button routes to new viewing party page', :vcr do
    visit movie_path(238)

    click_on ('Create Viewing Party for The Godfather')

    expect(current_path).to eq(movie_viewing_party_new_path(238))
  end
end
