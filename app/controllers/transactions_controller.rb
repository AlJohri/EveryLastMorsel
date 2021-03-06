class TransactionsController < ApplicationController
    
  def new
    @transaction = Transaction.new
    @crop_yield = CropYield.find_by_id(params[:crop_yield])
  end
  
  def create
    @transaction = Transaction.new(params[:transaction])
    @crop_yield = CropYield.find_by_id(params[:transaction][:crop_yield_id])
    @transaction.get_amount(@crop_yield)
    @transaction.user = current_user if current_user
    if @transaction.quantity_is_less_than?(@crop_yield)
      @braintree_result = @transaction.send_to_braintree(@crop_yield)
      if @braintree_result.success?
        redirect_to marketplace_path, notice: "Transaction has been successfully processed."
        @transaction.reduce_crop_yield_quantity
      else
        @transaction = Transaction.new(params[:transaction])
        render 'new'
      end
    else
      redirect_to new_transaction_path(crop_yield: @crop_yield.id), alert: "This transaction cannot be processed. Quantity of transaction must be lower than the crop yield quantity."
    end
  end

end
