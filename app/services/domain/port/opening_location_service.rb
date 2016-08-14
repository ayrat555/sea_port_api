class Domain::Port::OpeningLocationService < ApplicationService
  class OpeningLocationServiceError < ApplicationServiceError; end
  class OpeningLocationNotFoundError < OpeningLocationServiceError; end

  class << self
    def find_ships(params)
      result = []
      location = find_ship_opening_location(params[:id])
      cargo = location.portable


      nearby_ports(location).each do |port|
        open_ship_locations = Port::OpeningLocation.ships(port.id)
        open_ship_locations.each do |ship_loc|
          if ship_loc.matches_date?(location.first_date, location.last_date) &&
            ship_loc.portable.matches_volume?(cargo.volume)
              result.push(ship_loc)
          end
        end
      end
      result
    end

    def find_cargos(params)
      result = []
      location = find_cargo_opening_location(params[:id])
      ship = location.portable
      nearby_ports(location).each do |port|
        open_cargo_locations = Port::OpeningLocation.cargos(port.id)
        open_cargo_locations.each do |cargo_loc|
          if cargo_loc.matches_date?(location.first_date, location.last_date) &&
            cargo_loc.portable.matches_capacity?(ship.hold_capacity)
              result.push(cargo_loc)
          end
        end
      end
      result
    end

    private

      def nearby_ports(location)
        nearby_ports = location.port.nearbys(configus.distance).limit(configus.port_limit)
        nearby_ports.push location.port
      end

      def find_cargo_opening_location(id)
        location = Port::OpeningLocation.find_by_id(id)
        if (location.nil? || !location.ship?)
          raise OpeningLocationNotFoundError.new("ship opening location is not found with id #{id}")
        end
        location
      end

      def find_ship_opening_location(id)
        location = Port::OpeningLocation.find_by_id(id)
        if (location.nil? || !location.cargo?)
          raise OpeningLocationNotFoundError.new("cargo opening location is not found with id #{id}")
        end
        location
      end
  end
end
