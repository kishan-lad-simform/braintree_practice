class CheckoutsController < ApplicationController
  
  def new
    @client_token = Braintree::ClientToken.generate
    find_movie(params[:movie_id])
  end

  def create
    @movie = params[:movie_id]
    find_movie(@movie)
    amount = @price
    nonce = params["payment_method_nonce"]
    result = Braintree::Transaction.sale(
      amount: amount,
      payment_method_nonce: nonce,
      :options => {
        :submit_for_settlement => true
      }
    )
    if transaction_successful?(result.transaction)
      redirect_to checkout_path(result.transaction.id)
    else
      handle_transaction_errors(result.errors)
      render :new
    end
  end

  def show
    @transaction = Braintree::Transaction.find(params[:id])
    @result = _create_result_hash(@transaction)
  end

  private
    def find_movie(id)
      @movie = Movie.find(id)
      @price = @movie.price
    end

    def transaction_successful?(transaction)
       TRANSACTION_SUCCESS_STATUSES.include?(transaction.status)
    end

    def _create_result_hash(transaction)
      status = transaction.status
      if transaction_successful?(transaction)
        result_hash = {
          header: "Sweet Success!",
          icon: "success",
          message: "Your test transaction has been successfully processed."
        }
      else
        result_hash = {
          header: "Transaction Failed",
          icon: "fail",
          message: "Your test transaction has a status of #{status}."
        }
      end
    end

    def handle_transaction_errors(errors)
      error_messages = errors.map { |error| "Error: #{error.code}: #{error.message}" }
      flash[:error] = error_messages
    end
end