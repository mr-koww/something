class ApplicationController < ActionController::API

  protected

  def render_unprocessable(message)
    render json: { message: message }, status: :unprocessable_entity
  end
end
