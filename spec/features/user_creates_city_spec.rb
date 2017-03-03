require "rails_helper"

feature "Cities management" do
  let!(:country) do
    create(:country, name: 'Colombia', population: 60000000)
  end

  scenario "User creates city" do
    visit root_path
    expect{
      click_link 'New City'
      select 'Colombia', from: 'Country'
      fill_in 'Name', with: 'Bogota'
      fill_in 'Population', with: '60000000'
      click_button 'Create City'
    }.to change(City, :count).by(1)
    city = City.last
    expect(city).not_to be_nil
    expect(current_path).to eq city_path(city)
    expect(page).to have_content 'City was successfully created.'
  end
end