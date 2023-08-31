class Facility
  attr_reader :name, :address, :phone, :services

  def initialize(data)#bug 2 wrong format receiving a hash with multiple data inside. Only one argumen
    @name = name
    @address = address
    @phone = phone
    @services = []
  end

  def add_services(service)
    @services << service
  end
end
