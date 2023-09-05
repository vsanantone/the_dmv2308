require 'spec_helper'

RSpec.describe VehicleFactory do
  before(:each) do
    @factory = VehicleFactory.new
    @dmv_service = DmvDataService.new
    @wa_ev_registrations = @dmv_service.wa_ev_registrations

  end

  describe '#initialize' do
    it 'exist' do
      expect(@factory).to be_a(VehicleFactory)
    end

    it 'starts with no vehicles' do
      expect(@factory.vehicles).to eq([])
    end
  end

  describe '#create_wa_vehicles(dmv_data)' do
    it 'returns formated dmv_data' do
      # require 'pry'; binding.pry
      expect(@factory.create_wa_vehicles(@wa_ev_registrations)).to be_an(Array)
      expect(@factory.vehicles).to all(be_a(Vehicle))

      @factory.vehicles.each do |vehicle|
        expect(vehicle.vin).to be_a(String)
        expect(vehicle.year).to be_a(Integer)
        expect(vehicle.make).to be_a(String)
        expect(vehicle.model).to be_a(String)
        expect(vehicle.engine).to eq(:ev)
      end
    end
  end
end

