class SourcesController < ApplicationController

  def create
    source = Source.new(source_params)
    if source.save
      render json: { source: { id: source.id, name: source.name } }
    else
      render json: { errors: source.errors }, status: :unprocessable_entity
    end
  end

private
  def source_params
    params.require(:source).permit(:name)
  end
end