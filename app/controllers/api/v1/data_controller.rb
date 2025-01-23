require 'date'

class Api::V1::DataController < ApplicationController
  def history
    # Parámetros de entrada
    @currency = params[:currency].nil? ? "BTC" : params[:currency]
    @period_id = params[:period_id].nil? ? "year" : params[:period_id]
    @time_start = params[:time_start].nil? ? "2020-01-01" : params[:time_start]
    @time_end = params[:time_end].nil? ? "2024-12-31" : params[:time_end]

    # Validar que time_end no sea mayor a hoy
    today = Date.today
    end_date = Date.parse(@time_end)
    if end_date > today
      render json: { error: "time_end no puede ser mayor a la fecha actual." }, status: 400
      return
    end

    # Determinar el período de tiempo
    @period_aux = case @period_id
                  when "day" then "1DAY"
                  when "week" then "7DAY"
                  when "month" then "1MTH"
                  when "year" then "1YRS"
                  end

    # Convertir time_start y time_end a objetos Date
    start_date = Date.parse(@time_start)
    end_date = Date.parse(@time_end)

    # Generar un array de fechas de acuerdo al período solicitado
    @result = []
    current_date = start_date

    while current_date <= end_date
      # Buscar los registros correspondientes a la fecha actual
      response = History.where(currency_id: Currency.find_by(name: @currency).id)
                        .where(date: current_date)

      # Agregar los registros encontrados a la respuesta
      @result.concat(response)

      # Incrementar la fecha según el período
      case @period_id
      when "day"
        current_date += 1 # Un día
      when "week"
        current_date += 7 # Sumar 7 días para la siguiente semana
      when "month"
        current_date = current_date.next_month # Sumar 1 mes
      when "year"
        current_date = current_date.next_year # Sumar 1 año
      end
    end

    # Retornar los registros encontrados como JSON
    puts @result
  end
end
