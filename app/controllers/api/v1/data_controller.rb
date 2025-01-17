class Api::V1::DataController < ApplicationController
  def history
    puts "Prueba"
    #response = Faraday.get("http://apilayer.net/api/timeframe?access_key=#{ENV.fetch("CURRENCY_LAYER_API_KEY")}&start_date=2024-01-01&end_date=2024-12-31&currencies=EUR,COP")
    #response = Faraday.get("http://apilayer.net/api/live?access_key=ffbf949b5470e6f143d6e7e71b828a50&currencies=EUR,USD,CAD,PLN&source=COP&format=1")
    #puts response.status
    # Params for pagination
    @size = params[:size].nil? ? 5 : params[:size].to_i
    @page = params[:page].nil? ? 1 : params[:page].to_i
    
    #puts response.body
    conn = Faraday.new(
      url: 'https://rest.coinapi.io/v1/'
    )

    response = conn.get('exchangerate/history/periods',{}, {'Content-Type' => 'application/json', 'X-CoinAPI-Key' => "#{ENV.fetch('COIN_API_KEY')}"})
# => GET http://httpbingo.org/get?boom=zap
    


    render json: response

  end

end