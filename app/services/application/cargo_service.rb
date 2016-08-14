class Application::CargoService < ApplicationService
  class CargoServiceError < ApplicationServiceError; end
  class CargoNotFoundError < CargoServiceError; end

  class << self

    def create(params)
      params = ActionController::Parameters.new(params).permit(:volume, :name)
      cargo = Cargo.new(params)

      raise CargoServiceError.new(model: cargo.errors) unless cargo.save
      cargo
    end

    def find(params)
      cargo = Cargo.find_by_id(params[:id])
      raise CargoNotFoundError.new("cargo is not found with id #{params[:id]}") if cargo.nil?
      cargo
    end
  end
end
