class TransactionsController < ApplicationController
    
  def new
    @transaction = Transaction.new
    @crop_yield = CropYield.find_by_id(params[:crop_yield])
  end
  
  def create
    @transaction = Transaction.new(params[:transaction])
    @crop_yield = CropYield.find_by_id(params[:transaction][:crop_yield_id])
    
    if @transaction.save
      # error if purchasing too many
      # change crop_yield quantity to subtract from transaction quantity
    else
      render 'new'
    end
  end
end
