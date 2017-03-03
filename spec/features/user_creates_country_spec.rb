require "rails_helper"

feature "Countries management" do
  scenario "User creates country" do
    visit root_path
    expect{
      click_link "New Country"
      fill_in "Name", with: "Colombia"
      fill_in "Population", with: "60000000"
      click_button "Create Country"
    }.to change(Country, :count).by(1)
    country = Country.last
    expect(country).not_to be_nil
    expect(current_path).to eq country_path(country)
    expect(page).to have_content "Country was successfully created."
    visit root_path
    expect(page).to have_css 'table td', text: "Colombia"
  end
end