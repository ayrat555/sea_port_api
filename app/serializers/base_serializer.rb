class BaseSerializer < ActiveModel::Serializer
  def json_key
    'data'
  end
end