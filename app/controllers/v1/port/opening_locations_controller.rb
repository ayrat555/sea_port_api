class V1::Port::OpeningLocationsController < V1::ApplicationController
  def create
    @location = Application::Port::OpeningLocationService.create(params)
    render json: @location, status: :created
  end

  def find_ships
    @ship_locations = Application::Port::OpeningLocationService.find_ships(params)
    render json: @ship_locations
  end

  def find_cargos
    @cargo_locations = Application::Port::OpeningLocationService.find_cargos(params)
    render json: @cargo_locations
  end
end
