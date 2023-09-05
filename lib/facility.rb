class Facility
  attr_reader :name, :address, :phone, :services, 
                     :registered_vehicles, :collected_fees

  def initialize(data)
    @name                = data[:name]
    @address             = data[:address]
    @phone               = data[:phone]
    @services            = []
    @registered_vehicles = []
    @collected_fees      = 0
  end

  def add_service(service)
    @services << service
  end

  def register_vehicle(vehicle)
    @registered_vehicles << vehicle
  end

  def rcollected_fees(vehicle)
    if vehicle.engine == :ev
      @collected_fees += 200
   elsif Date.today.year - vehicle.year < 25
     @collected_fees += 100
   else
     @collected_fees += 25
   end
  end

  def administer_written_test(registrant)
    if @services.include?("Written Test")
      if registrant.age >=16 && registrant.permit?
        registrant.license_data[:written] = true 
      end
    end
  registrant.license_data[:written]
  end

  def administer_road_test(registrant)
    if @services.include?("Road Test")
      if registrant.license_data[:written] == true
        registrant.license_data[:license] = true 
      end
    end
  registrant.license_data[:license]
  end

  def renew_drivers_license(registrant)
    if @services.include?("Renew License")
      if registrant.license_data[:license] == true
        registrant.license_data[:renewed] = true 
      end
    end
  registrant.license_data[:renewed]
  end
end
