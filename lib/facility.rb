class Facility
  attr_reader :name, :address, :phone, :services, 
                     :registered_vehicles, :collected_fees

  def initialize(data)#bug 2 wrong format receiving a hash with multiple data inside. Only one argumen
    @name                = data[:name]#bug 3
    @address             = data[:address]
    @phone               = data[:phone]
    @services            = []
    @registered_vehicles = []
    @collected_fees      = 0
  end

  def add_service(service)#bug 4 singular service added one at a time
    @services << service
  end

  def register_vehicle(vehicle)
    @registered_vehicles << vehicle
  end
end
