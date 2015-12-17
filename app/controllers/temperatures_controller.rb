class TemperaturesController < ApplicationController
  def index
    @temperatures = Temperature.last(10)
    dates = ['x']
    degree = ['気温']
    @temperatures.each do |data|
      dates << "#{data.created_at.strftime('%d %M')}"
      degree << data.centigrade
    end
    gon.ttevents = [dates, degree]
  end
end
