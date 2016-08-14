class V1::ShipsController < V1::ApplicationController
  def create
    @ship = Application::ShipService.create(params)
    render json: @ship, status: :created
  end

  def show
    @ship = Application::ShipService.find(params)
    render json: @ship
  end
end
