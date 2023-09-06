class VehicleFactory
  attr_reader :vehicles

  def initialize
    @vehicles = []
  end

  def create_wa_vehicles(dmv_data)
    dmv_data.each do |registration|
      vehicles << Vehicle.new({
        vin: registration[:vin_1_10],
        year: registration[:model_year].to_i,
        make: registration[:make],
        model: registration[:model],
        engine: :ev
      })
    end
  end
end

