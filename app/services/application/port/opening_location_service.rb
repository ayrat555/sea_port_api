class Application::Port::OpeningLocationService < ApplicationService
  class OpeningLocationServiceError < ApplicationServiceError; end
  class PortableNotFoundError < OpeningLocationServiceError; end

  class << self

    def create(params)
      portable = find_portable(params[:portable_id])
      opening_location = Port::OpeningLocation.new
      opening_location.portable = portable
      opening_location.first_date = Time.at(params[:first_date]).to_date
      opening_location.last_date = Time.at(params[:last_date]).to_date
      opening_location.port_id = params[:port_id]
      raise OpeningLocationServiceError.new(model: opening_location.errors) unless opening_location.save
      opening_location
    end

    def find_ships(params)
      Domain::Port::OpeningLocationService.find_ships(params)
    end

    def find_cargos(params)
      Domain::Port::OpeningLocationService.find_cargos(params)
    end

    private

      def find_portable(id)
        Ship.find_by_id(id) || Cargo.find_by_id(id) ||
          (raise PortableNotFoundError.new("No ships and cargos are found by id #{id}"))
      end
  end
end
