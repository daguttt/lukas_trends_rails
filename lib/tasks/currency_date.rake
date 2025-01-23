namespace :histories do
  desc 'Get currency data to the day, save to database and send email to users'
  task currency_date: :environment do
    conn = Faraday.new(
      url: 'https://rest.coinapi.io'
    )

    # Currency
    currencies = %w[USD EUR BTC ETH LTC]
    # tiempo=Time.new();
    # puts tiempo.strftime('%Y-%m-%d')
    money = []
    currencies.each do |currency|
      response = conn.get("/v1/exchangerate/#{currency}/COP", {},
                          { 'Content-Type' => 'application/json', 'X-CoinAPI-Key' => ENV.fetch('COIN_API_KEY') })

      # convert string to json
      lukas = JSON.parse(response.body)

      date = lukas['time'].split('T')
      puts "day: #{date[0]}"
      puts 'THIS IS THE RESPONSE'

      price = (lukas['rate'] / 1000.0).round(2) # get 3 decimal
      currency_model = Currency.find_by(symbol: currency)
      puts
      History.create!(currency_id: currency_model.id, date: date[0], lukas_value: price)

    end

  end
end
