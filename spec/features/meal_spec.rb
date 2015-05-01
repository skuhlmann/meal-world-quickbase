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

  it "can add a meal and delete it" do
    visit '/'
    click_link("What did you eat today?")
    fill_in("meal_name", with: "Hot Dogs")
    fill_in("meal_description", with: "All Pork. Lot's of mustard")
    fill_in("meal_category", with: "Street Food")
    fill_in("meal_rating", with: "5")
    click_button("Add meal")

    expect(page).to have_text("You added a meal")
    expect(page).to have_text("Hot Dog")

    click_button("Delete Hot Dog")
    expect(current_path).to eq(meals_path)
    expect(page).to have_text("You deleted a meal")
    expect(page).not_to have_text("Hot Dog")
  end

  it "can edit a meal" do
    visit '/'
    click_link("What did you eat today?")
    fill_in("meal_name", with: "Hot Dogs")
    fill_in("meal_description", with: "All Pork. Lot's of mustard")
    fill_in("meal_category", with: "Street Food")
    fill_in("meal_rating", with: "5")
    click_button("Add meal")
    click_link("Edit meal")
    fill_in("meal_name", with: "Corn Dogs")
    click_button("Update meal")

    expect(page).to have_text("Corn Dogs")
    expect(page).to have_text("You updated this meal")

    click_button("Delete Corn Dogs")
  end
end


