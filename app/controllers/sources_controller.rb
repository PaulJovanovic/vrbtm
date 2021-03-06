class SourcesController < ApplicationController

  def create
    @source = Source.exact_search_by_name(source_params[:name].strip).last || Source.create(source_params)
    if @source.persisted?
      render json: { id: @source.id, name: @source.name }
    else
      render json: { errors: @source.errors }, status: :unprocessable_entity
    end
  end

  def show
    @source = Source.friendly.find(params[:id])
  end

  def search
    name = params[:name].strip()
    if name[0] == "@"
      sources = User.search_by_name(name[1, name.length - 1])
    else
      sources = Source.search_by_name(name)
    end

    render json: sources.map { |source| { id: source.id, name: source.name, image: source.search_image, info: "#{source.search_info}" } }, status: 200
  end

private
  def source_params
    params.require(:source).permit(:name)
  end
end
