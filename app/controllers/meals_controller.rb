class MealsController < ApplicationController
  def index
    @meals = Meal.all
  end

  def show
    @meal = Meal.find(params["id"])
  end

  def new
  end

  def create
    response = Meal.create(meal_params)
    meal_id = response["qdbapi"]["rid"]
    flash[:notice] = "You added a meal"
    redirect_to meal_path(meal_id)
  end

  def edit
    @meal = Meal.find(params["id"])
  end

  def update
    Meal.update(params["id"], meal_params)
    flash[:notice] = "You updated this meal"
    redirect_to meal_path(params["id"])
  end

  def destroy
    meal_id = params["id"]
    Meal.delete(meal_id)
    flash[:notice] = "You deleted a meal"
    redirect_to meals_path
  end

  private

  def meal_params
    params.require(:meal).permit(:name, :description, :rating, :category)
  end
end
