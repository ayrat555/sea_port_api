require 'test_helper'

class V1::ShipsControllerTest < ActionController::TestCase

  test 'should create ship' do
    post :create, { format: :json, name: 'Ship', hold_capacity: 5000}
    assert_response :created
    assert_not_nil Ship.find_by(name: 'Ship', hold_capacity: 5000)
    assert json_response['name'] == 'Ship'
    assert json_response['hold_capacity'] == 5000
  end

  test 'should show error in name' do
    post :create, { format: :json, hold_capacity: 5000}
    assert json_response['name'] == ["can't be blank"]
    assert_response :unprocessable_entity
  end

  test 'should show Ship' do
    id = Ship.create(name: 'Ship', hold_capacity: 5000).id
    get :show, {format: :json, id: id}
    assert json_response['name'] == 'Ship'
    assert json_response['hold_capacity'] == 5000
  end

  test 'shouldnt show not existing Ship' do
    get :show, {format: :json, id: 999}
    assert json_response['base'] == ["ship is not found with id 999"]
  end
end
