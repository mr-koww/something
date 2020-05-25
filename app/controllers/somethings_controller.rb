class SomethingsController < ApplicationController
  def index
    @manager = QueryManager.new(params, Something.all)
  end

  def create
    something = Something.new(permitted_params)
    render_unprocessable(something.errors.full_messages) unless something.save
  end

  private

  def permitted_params
    params.require(:something).permit(:title)
  end
end
