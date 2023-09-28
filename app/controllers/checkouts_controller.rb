class CheckoutsController < ApplicationController
  # before_action :find_movie, only: [ :new, :create ]
  TRANSACTION_SUCCESS_STATUSES = [
    Braintree::Transaction::Status::Authorizing,
    Braintree::Transaction::Status::Authorized,
    Braintree::Transaction::Status::Settled,
    Braintree::Transaction::Status::SettlementConfirmed,
    Braintree::Transaction::Status::SettlementPending,
    Braintree::Transaction::Status::Settling,
    Braintree::Transaction::Status::SubmittedForSettlement,
  ]

  def new
    @client_token = Braintree::ClientToken.generate
    find_movie(params[:movie_id])
  end

  def show
    @transaction = Braintree::Transaction.find(params[:id])
    @result = _create_result_hash(@transaction)
  end

  def create
    @movie = params[:movie_id]
    find_movie(@movie)
    amount = @price# In production you should not take amounts directly from clients
    nonce = params["payment_method_nonce"]
    result = Braintree::Transaction.sale(
      amount: amount,
      payment_method_nonce: nonce,
      :options => {
        :submit_for_settlement => true
      }
    )
    
    if result.success? || result.transaction
      redirect_to checkout_path(result.transaction.id)
    else
      error_messages = result.errors.map { |error| "Error: #{error.code}: #{error.message}" }
      flash[:error] = error_messages
      render new_checkout_url(@movie_id)
    end
  end

  def _create_result_hash(transaction)
    status = transaction.status

    if TRANSACTION_SUCCESS_STATUSES.include? status
      result_hash = {
        header: "Sweet Success!",
        icon: "success",
        message: "Your test transaction has been successfully processed. See the Braintree API response and try again."
      }
    else
      result_hash = {
        header: "Transaction Failed",
        icon: "fail",
        message: "Your test transaction has a status of #{status}. See the Braintree API response and try again."
      }
    end
  end

  def gateway
    env = ENV["BT_ENVIRONMENT"]
    @gateway ||= Braintree::Gateway.new(
      :environment => env && env.to_sym,
      :merchant_id => ENV["MERCHANT_ID"],
      :public_key => ENV["PUBLIC_ID"],
      :private_key => ENV["PRIVATE_ID"],
    )
  end

  def find_movie(id)
    @movie = Movie.find(id)
    @price = @movie.price
  end
end