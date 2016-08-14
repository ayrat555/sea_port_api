require 'test_helper'

class V1::Port::OpeningLocationsControllerTest < ActionController::TestCase

  test 'should create opening location' do
    port = ::Port.first
    ship = Ship.create(name: "Argo", hold_capacity: 5000)
    post :create, {
      format: :json,
      port_id: port.id,
      portable_id: ship.id,
      first_date: Time.now.to_i,
      last_date: (Time.now + 5.days).to_i
    }
    assert_response :created
    assert Port::OpeningLocation.find_by_id(json_response[:id])
    assert json_response[:port][:title] == port.title
  end

  test 'should return error in port on creation' do
    ship = Ship.create(name: "Argo", hold_capacity: 5000)
    post :create, {
      format: :json,
      port_id: 999,
      portable_id: ship.id,
      first_date: Time.now.to_i,
      last_date: (Time.now + 5.days).to_i
    }
    assert json_response[:port] == ["can't be blank"]
  end

  test 'should return error in portable on creation' do
    port = ::Port.first
    post :create, {
      format: :json,
      port_id: port.id,
      portable_id: 999,
      first_date: Time.now.to_i,
      last_date: (Time.now + 5.days).to_i
    }
    assert json_response[:base] == ["No ships and cargos are found by id 999"]
  end

  test 'finds nearby ships' do
    port = ::Port.first
    cargo = Cargo.create(name: 'Cargo', volume: 5000)
    ship = Ship.create(name: 'Argo', hold_capacity: 6000 )
    cargo_opening_location = Port::OpeningLocation.create(
      port: port,
      portable: cargo,
      first_date: Time.now,
      last_date: Time.now + 5.days
    )

    ship_opening_location = Port::OpeningLocation.create(
      port: port,
      portable: ship,
      first_date: Time.now - 1.day,
      last_date: Time.now + 6.days
    )
    get :find_ships, {format: :json, id: cargo_opening_location.id}
    assert json_response[0]
    assert json_response[0][:portable][:name] == ship.name
    assert json_response[0][:portable][:id] == ship.id
    assert json_response[0][:port][:title] == port.title
  end

  test 'finds nearby cargos' do
    port = ::Port.first
    cargo = Cargo.create(name: 'Cargo', volume: 5000)
    ship = Ship.create(name: 'Argo', hold_capacity: 6000 )
    cargo_opening_location = Port::OpeningLocation.create(
      port: port,
      portable: cargo,
      first_date: Time.now - 1,
      last_date: Time.now + 6.days
    )

    ship_opening_location = Port::OpeningLocation.create(
      port: port,
      portable: ship,
      first_date: Time.now,
      last_date: Time.now + 2.days
    )
    get :find_cargos, {format: :json, id: ship_opening_location.id}
    assert json_response[0]
    assert json_response[0][:portable][:name] == cargo.name
    assert json_response[0][:portable][:id] == cargo.id
    assert json_response[0][:port][:title] == port.title
  end

  test 'returns error if cargo doesnt exist' do
    get :find_cargos, {format: :json, id: 555}
    assert json_response[:base] == ["ship opening location is not found with id 555"]
  end

  test 'doesnt return ship if its capacity < cargo volume' do
    port = ::Port.first
    cargo = Cargo.create(name: 'Cargo', volume: 5000)
    ship = Ship.create(name: 'Argo', hold_capacity: 2000 )
    cargo_opening_location = Port::OpeningLocation.create(
      port: port,
      portable: cargo,
      first_date: Time.now,
      last_date: Time.now + 5.days
    )

    ship_opening_location = Port::OpeningLocation.create(
      port: port,
      portable: ship,
      first_date: Time.now - 1.day,
      last_date: Time.now + 6.days
    )
    get :find_ships, {format: :json, id: cargo_opening_location.id}
    assert json_response.empty?
  end

  test 'doesnt return cargo if its volume > ship capacity' do
    port = ::Port.first
    cargo = Cargo.create(name: 'Cargo', volume: 5000)
    ship = Ship.create(name: 'Argo', hold_capacity: 2000 )
    cargo_opening_location = Port::OpeningLocation.create(
      port: port,
      portable: cargo,
      first_date: Time.now,
      last_date: Time.now + 5.days
    )

    ship_opening_location = Port::OpeningLocation.create(
      port: port,
      portable: ship,
      first_date: Time.now - 1.day,
      last_date: Time.now + 6.days
    )
    get :find_cargos, {format: :json, id: ship_opening_location.id}
    assert json_response.empty?
  end
end
