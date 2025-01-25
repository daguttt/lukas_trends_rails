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
end
