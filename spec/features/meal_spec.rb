require "rails_helper"

describe "Meal flow", type: :feature do

  it "can see the meal list on the homepage" do
    visit '/'

    expect(page).to have_text("Cheeseburgers")
    expect(page).to have_text("Spaghetti")
  end

  it "can see a single meal detail" do
    visit '/'
    click_link("Meal details", match: :first)

    expect(current_path).to eq('/meals/2')
    expect(page).to have_text("Cheeseburgers")
  end
end


