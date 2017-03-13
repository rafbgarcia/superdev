class Superdev::Error < StandardError
  attr_reader :error_message, :status

  def initialize(error_message, status = :bad_request)
    @error_message = error_message
    @status = status
  end

  def response_data
    {
      error_message: error_message,
    }
  end

end
