class Application::ShipService < ApplicationService
  class ShipServiceError < ApplicationServiceError; end
  class ShipNotFoundError < ShipServiceError; end

  class << self

    def create(params)
      params = ActionController::Parameters.new(params).permit(:name, :hold_capacity)
      ship = Ship.new(params)

      raise ShipServiceError.new(model: ship.errors) unless ship.save
      ship
    end

    def find(params)
      ship = Ship.find_by_id(params[:id])
      raise ShipNotFoundError.new("ship is not found with id #{params[:id]}") if ship.nil?
      ship
    end
  end
end
