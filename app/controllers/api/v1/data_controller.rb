class Api::V1::DataController < ApplicationController
  def history
    @currency = params[:currency].presence || 'BTC'
    @period_id = params[:period_id].presence || 'year'
    @time_start = params[:time_start].presence || '2020-01-01'
    @time_end = params[:time_end].presence || Date.today.to_s

    # Validar que time_end no sea mayor a hoy
    today = Date.today
    end_date = Date.parse(@time_end)
    if end_date > today
      render json: { error: 'time_end no puede ser mayor a la fecha actual.' }, status: :bad_request
      return
    end

    # Convertir time_start y time_end a objetos Date
    start_date = Date.parse(@time_start)
    end_date = [end_date, today].min

    # Determinar intervalo en días
    interval = case @period_id
               when 'day' then 1
               when 'week' then 7
               when 'month' then 30
               when 'year' then 365
               else 1
               end

    # Generar los datos
    currency = Currency.find_by(name: @currency)
    if currency.nil?
      render json: { error: 'Moneda no encontrada' }, status: :not_found
      return
    end

    history_data = []
    dates = []

    (start_date..end_date).step(interval).each do |date|
      history = History.find_by(currency_id: currency.id, date: date)
      history_data << (history&.lukas_value || 0)
      dates << date.strftime('%Y-%m-%d')
    end

    render json: { dates: dates, values: history_data }
  end

  def history2
    @currency = params[:currency].presence || 'BTC'
    @period_id = params[:period_id].presence || 'year'
    @time_start = params[:time_start].presence || '2020-01-01'
    @time_end = params[:time_end].presence || Date.today.to_s

    # Validate that time_end is not greater than today
    today = Date.today
    end_date = Date.parse(@time_end)
    if end_date > today
      render json: { error: 'time_end cannot be greater than today.' }, status: :bad_request
      return
    end

    # Parse time_start and time_end as Date objects
    start_date = Date.parse(@time_start)
    end_date = [end_date, today].min

    # Determine interval in days
    interval = case @period_id
               when 'day' then 1
               when 'week' then 7
               when 'month' then 30
               when 'year' then 365
               else 1
               end

    # Fetch the currency
    currency = Currency.find_by(name: @currency)
    if currency.nil?
      render json: { error: 'Currency not found' }, status: :not_found
      return
    end

    # Fetch all history records in the date range with a single query
    histories = History
                .where(currency_id: currency.id, date: start_date..end_date)
                .order(:date)

    # Organize data into the desired format
    history_map = histories.index_by(&:date) # Create a hash { date => history }
    dates = (start_date..end_date).step(interval).map do |date|
      {
        date: date.strftime('%Y-%m-%d'),
        value: history_map[date]&.lukas_value || 0
      }
    end

    # Prepare the JSON response
    render json: {
      dates: dates.map { |entry| entry[:date] },
      values: dates.map { |entry| entry[:value] }
    }
  end
end
