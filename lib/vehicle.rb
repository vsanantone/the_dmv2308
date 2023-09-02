require 'date'

class Vehicle
  attr_reader :vin,
              :year,
              :make,
              :model,
              :engine,
              :registration_date #bug1

  def initialize(vehicle_details)
    @vin                = vehicle_details[:vin]
    @year               = vehicle_details[:year]
    @make               = vehicle_details[:make]
    @model              = vehicle_details[:model]
    @engine             = vehicle_details[:engine]
    @registration_date  = nil
  end

  def antique?
    Date.today.year - @year > 25
  end

  def electric_vehicle?
    @engine == :ev
  end

  def new_registration_date
     @registration_date = Date.today
  end

  def plate_type
    if Date.today.to_s[0, 4].to_i - @year < 25
      :regular
    else
      :antique
    end
  end
  
end
