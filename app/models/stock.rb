class Stock < ApplicationRecord

  has_many :user_stocks
  has_many :users, through: :user_stocks

  validates :name, :ticker_symbol, presence: true

  def self.new_lookup(ticker_symbol)
    client = IEX::Api::Client.new(
        publishable_token: Rails.application.credentials.iex_client[:sandbox_api_publishable_key],
        secret_token: Rails.application.credentials.iex_client[:sandbox_api_secret_key],
        endpoint: 'https://sandbox.iexapis.com/v1'
    )
    # client.price(ticker_symbol)
    begin
      new(name: client.company(ticker_symbol).company_name, ticker_symbol: ticker_symbol, price: client.price(ticker_symbol))
    rescue => exception
      return nil
    end
  end

  def self.check_db(ticker_symbol)
    where(ticker_symbol: ticker_symbol).first
  end


end