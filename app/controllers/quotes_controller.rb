class QuotesController < ApplicationController
  def create
    quote = Quote.new(quote_params)

    if quote.save
      render json: { quote: { id: quote.id, citable_type: quote.citable_type, citable_id: quote.citable_id, text: quote.text } }
    else
      render json: { errors: quote.errors }, status: :unprocessable_entity
    end
  end

private
  def quote_params
    params.require(:quote).permit(:text, :citable_type, :citable_id)
  end
end