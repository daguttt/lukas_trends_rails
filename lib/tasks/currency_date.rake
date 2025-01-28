namespace :histories do
  desc 'Get currency data to the day, save to database and send email to users'
  task currency_date: :environment do

    #Get data from scraping
    # EUR
    response = Faraday.get('https://wise.com/gb/currency-converter/eur-to-cop-rate')
    html_doc = Nokogiri::HTML(response.body)

    euro = 0.0
    #class text-success return two values, we pick up the last one cause is rounded
    html_doc.css('.text-success').each do |value|
      euro = value.text.strip
    end
    euro = euro.delete(',').to_f
    euro = format('%.2f', euro)
    #convert to lukas
    euro = euro/1000.0
    puts "These is euro #{euro}"

    
    #USD

    response2 = Faraday.get('https://wise.com/gb/currency-converter/usd-to-cop-rate')
    html_doc2 = Nokogiri::HTML(response2.body)

    dolar = 0.0
    #class text-success return two values, we pick up the last one cause is rounded
    html_doc2.css('.text-success').each do |value2|
      dolar = value2.text.strip
    end

    dolar = dolar.delete(',').to_f
    dolar = format('%.2f', dolar)
    #convert to lukas
    dolar = dolar/1000.0
    puts "This is dollar #{dolar}"


    #bitcoin
    response3 = Faraday.get('https://www.google.com/finance/quote/BTC-COP')
    html_doc3 = Nokogiri::HTML(response3.body)

    value3 = html_doc3.css('.fxKbKc')
    bitcoin = value3.text.strip
    bitcoin = bitcoin.delete(',').to_f
    bitcoin = format('%.2f', bitcoin)
    #convert to lukas
    bitcoin = bitcoin/1000.0
    puts "this is bitcoin #{bitcoin}"


    #etherium
    response4 = Faraday.get('https://www.google.com/finance/quote/ETH-COP')
    html_doc4 = Nokogiri::HTML(response4.body)

    value4 = html_doc4.css('.fxKbKc')
    ethereum = value4.text.strip
    ethereum = ethereum.delete(",").to_f
    ethereum = format('%.2f', ethereum)
    #convert to lukas
    ethereum = ethereum/1000.0
    puts "this is etherium #{ethereum}"

    money = [{"Dolar" => dolar},
             {"Euro" => euro},
             {"Bitcoin" => bitcoin},
             {"Ethereum" => ethereum}
    ]

    # Currency
    # currencies = %w[USD EUR BTC ETH]
    
    # money = []
    # currencies.each do |currency|
    #   response = conn.get("/v1/exchangerate/#{currency}/COP", {},
    #                       { 'Content-Type' => 'application/json', 'X-CoinAPI-Key' => ENV.fetch('COIN_API_KEY') })

    #   # convert string to json
    #   lukas = JSON.parse(response.body)

    #   date = lukas['time'].split('T')
    #   puts "day: #{date[0]}"

    #   price = (lukas['rate'] / 1000.0).round(2) # get 3 decimal
    #   currency_model = Currency.find_by(symbol: currency)
    #   History.create!(currency_id: currency_model.id, date: date[0], lukas_value: price)

    #   money << {currency_model.description => price}
    # end

    users = User.all

    users.each do |user|
      UserMailer.welcome_email(user, money).deliver_now
    end
    puts "Esto es Users #{User.all.inspect}"
    
  end
end
