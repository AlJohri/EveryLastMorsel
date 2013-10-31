class TransactionsController < ApplicationController
    
  def new
    @transaction = Transaction.new
    @crop_yield = CropYield.find_by_id(params[:crop_yield])
  end
  
  def create
    @transaction = Transaction.new(params[:transaction])
    @crop_yield = CropYield.find_by_id(params[:transaction][:crop_yield_id])
    @transaction.get_amount(@crop_yield)
    if @transaction.save # add error if purchasing too many
      redirect_to marketplace_path, notice: "Transaction has been saved."
      @transaction.reduce_crop_yield_quantity
    else
      render 'new'
    end
  end
end
