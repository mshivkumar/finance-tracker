class StocksController < ApplicationController

  def search
    if params[:stock].present?
      @stock = Stock.new_lookup(params[:stock])
      if @stock
        respond_to do |format|
          format.js { render partial: 'users/result' }
        end
        # render 'users/my_portfolio'
      else
        respond_to do |format|
          flash.now[:alert] = "Please provide a valid symbol"
          format.js { render partial: 'users/result' }
        end
      end
    else
      respond_to do |format|
        flash.now[:alert] = "Please provide a symbol"
        format.js { render partial: 'users/result' }
      end
    end
  end

end