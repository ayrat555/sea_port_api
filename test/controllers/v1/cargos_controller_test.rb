require 'test_helper'

class V1::CargosControllerTest < ActionController::TestCase

  test 'should create cargo' do
    post :create, { format: :json, name: 'Cargo', volume: 5000}
    assert_response :created
    assert_not_nil Cargo.find_by(name: 'Cargo', volume: 5000)
    assert json_response['name'] == 'Cargo'
    assert json_response['volume'] == 5000
  end

  test 'should show error in name' do
    post :create, { format: :json, volume: 5000}
    assert json_response['name'] == ["can't be blank"]
    assert_response :unprocessable_entity
  end

  test 'should show cargo' do
    id = Cargo.create(name: 'Cargo', volume: 5000).id
    get :show, {format: :json, id: id}
    assert json_response['name'] == 'Cargo'
    assert json_response['volume'] == 5000
  end

  test 'shouldnt show not existing cargo' do
    get :show, {format: :json, id: 999}
    assert json_response['base'] == ["cargo is not found with id 999"]
  end
end
