class ApplicationBaseError < RuntimeError
  attr_reader :model
  def initialize(message = nil, model: nil, status: nil)
    @message = message
    @model = model
    @status = status
  end

  def status
    @status || :unprocessable_entity
  end

  def message
    @message || 'No error message'
  end

  def error_object
    body.merge({ base: [message] })
  end

  def body
    return {} if @model.nil?
    return @model if @model.kind_of?(Hash)
    if ActiveModel::Serializer.serializer_for(@model).present?
      ActiveModel::SerializableResource.new(@model).serializable_hash
    else
      @model.as_json
    end
  end

  def as_json
    { message: message, status: status, body: body }
  end

  def inspect
    message
  end

  def to_s
    message
  end
end
