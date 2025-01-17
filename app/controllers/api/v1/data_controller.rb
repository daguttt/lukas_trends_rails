class Api::V1::DataController < ApplicationController
  def history
    #this api retrieve the value of a currency in 5 years, you choose the period of time day, week, month, year
    #/api/v1/data/history?currency=currency_name&period_id=value&:time_start=YYYY-MM-DD&time_end=YYYY-MM-DD
    #for history will be used to api one from CoinApi and other one form current layer
    #params:
    #currency: BTC->bitcoin, ETH -> ethereum, USDT -> Tether, EUR -> Euro
    #period_id: day-> day, week -> week, month -> month , year -> year
    #time_start -> YYYY-MM-DD
    #time_end -> yyyy-MM-DD

    #response = Faraday.get("http://apilayer.net/api/timeframe?access_key=#{ENV.fetch("CURRENCY_LAYER_API_KEY")}&start_date=2024-01-01&end_date=2024-12-31&currencies=EUR,COP")
    #response = Faraday.get("http://apilayer.net/api/live?access_key=ffbf949b5470e6f143d6e7e71b828a50&currencies=EUR,USD,CAD,PLN&source=COP&format=1")
    @currency= params[:currency].nil? ? "BTC" : params[:currency]
    @period_id = params[:period_id].nil? ? "year" : params[:period_id]
    @time_start = params[:time_start].nil? ? "2020-01-01" : params[:time_start]
    @time_end = params[:time_end].nil? ? "2024-12-31" : params[:time_end]
    
    #organize the period of time
    case @period_id
    when "day"
      @period_aux = "1DAY"
    when "week"
      @period_aux = "7DAY"
    when "month"
       @period_aux = "1MTH"
    when "year"
       @period_aux = "1YRS"
    end

    #puts response.body
    conn = Faraday.new(
      url: "https://rest.coinapi.io"
    )

    response = conn.get("/v1/ohlcv/BITSTAMP_SPOT_#{@currency}_USD/history?period_id=#{@period_aux}&time_start=#{@time_start}T00%3A00%3A00&time_end=#{@time_end}T23%3A59%3A59&limit=2000",{}, {'Content-Type' => 'application/json', 'X-CoinAPI-Key' => "#{ENV.fetch('COIN_API_KEY')}"})
    puts "THIS IS THE RESPONSE"
    puts "/v1/ohlcv/BITSTAMP_SPOT_#{@currency}_USD/history?period_id=#{@period_aux}&time_start=#{@time_start}T00%3A00%3A00&time_end=#{@time_end}T23%3A59%3A59&limit=2000"
    response.body

    #Parse the JSON string
    history = JSON.parse(response.body)

    lukas = convert_lukas("day",@time_start,@time_end, history)
    #puts lukas.class


    render json: lukas

  end

  private

  def convert_lukas(period_id,time_start,time_end, history_data)
      #this function will convert to lukas value
      #Remember that lukas means 1 dolar in values of colombian pesos

      conn = Faraday.new(
      url: "http://apilayer.net/api"
    )

    response = conn.get("/timeframe",{access_key: ENV.fetch('CURRENCY_LAYER_API_KEY'), start_date: time_start, end_date: time_end, currencies: "COP" }, {'Content-Type' => 'application/json'})

    #Parse the JSON string
    lukas_history = []
    lukas = JSON.parse(response.body)
    history_data.each do |data|
      time = data["time_period_start"].split("T")
      puts "day: #{time[0]} value #{data["price_close"]}"
      cop_day = lukas["quotes"][time[0]]["USDCOP"]
      #organize for history
      lukas_history << {time[0] => data["price_close"]*cop_day}
    end

    puts lukas["quotes"]

    lukas_history


  end



end