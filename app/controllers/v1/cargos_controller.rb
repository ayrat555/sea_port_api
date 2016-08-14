class V1::CargosController < V1::ApplicationController
  def create
    @cargo = Application::CargoService.create(params)
    render json: @cargo, status: :created
  end

  def show
    @cargo = Application::CargoService.find(params)
    render json: @cargo
  end
end
