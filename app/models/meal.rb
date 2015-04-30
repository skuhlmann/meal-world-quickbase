class Meal
  attr_accessor :record_id, :name, :description, :rating, :category

  def initialize(data)
    @record_id = data["record_id_"].to_i
    @name = data["name"]
    @description = data["description"]
    @rating = data["rating"].to_f
    @category = data["category"]
  end

  def self.service
    @service ||= QuickbaseService.new
  end

  def self.all
    service.find_all.map { |record| build_meal(record) }
  end

  def self.find(id)
    build_meal(service.find_by_record_id(id))
  end

  private

  def self.build_meal(data)
    Meal.new(data)
  end
end
