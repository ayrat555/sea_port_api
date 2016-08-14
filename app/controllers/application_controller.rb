class ApplicationController < ActionController::Base
  rescue_from ApplicationBaseError, with: :rescue_from_application_base_error

  private

    def rescue_from_application_base_error(ex)
      render json: ex.error_object, status: ex.status
    end
end
