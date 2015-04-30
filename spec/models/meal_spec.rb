require 'rails_helper'

RSpec.describe Meal, :type => :model do
  let(:valid_data) { {
    "name"=>"Spaghetti",
    "description"=>"With read sauce and meatballs",
    "rating"=>"3.0",
    "category"=>"Italian",
    "record_id"=>"1"
  } }

  it "creates a valid meal" do
    meal = Meal.new(valid_data)

    expect(meal.class).to eq(Meal)
    expect(meal.name).to eq("Spaghetti")
    expect(meal.description).to eq("With read sauce and meatballs")
    expect(meal.rating).to eq(3.0)
    expect(meal.category).to eq("Italian")
    expect(meal.record_id).to eq(1)
  end
end

