class PeoplesController < ApplicationController
  def search
    name = params[:name].strip()
    sources = User.search_by_name(name) + Source.search_by_name(name)

    render json: sources.map { |source| { id: source.id, name: source.name, url: send("#{source.class.name.downcase}_path", source.slug), image: source.search_image } }
  end
end
