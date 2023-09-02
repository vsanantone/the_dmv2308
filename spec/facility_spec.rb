require 'spec_helper'

RSpec.describe Facility do
  before(:each) do
    @facility_1 = Facility.new({name: 'DMV Tremont Branch', address: '2855 Tremont Place Suite 118 Denver CO 80205', phone: '(720) 865-4600'})
    @facility_2 = Facility.new({name: 'DMV Northeast Branch', address: '4685 Peoria Street Suite 101 Denver CO 80239', phone: '(720) 865-4600'})
    
    @cruz = Vehicle.new({vin: '123456789abcdefgh', year: 2012, make: 'Chevrolet', model: 'Cruz', engine: :ice} )
    @bolt = Vehicle.new({vin: '987654321abcdefgh', year: 2019, make: 'Chevrolet', model: 'Bolt', engine: :ev} )
    @camaro = Vehicle.new({vin: '1a2b3c4d5e6f', year: 1969, make: 'Chevrolet', model: 'Camaro', engine: :ice} )
  end

  describe '#initialize' do
    it 'can initialize' do
      expect(@facility_1).to be_an_instance_of(Facility)
      expect(@facility_1.name).to eq('DMV Tremont Branch')
      expect(@facility_1.address).to eq('2855 Tremont Place Suite 118 Denver CO 80205')
      expect(@facility_1.phone).to eq('(720) 865-4600')
      expect(@facility_1.services).to eq([])
    end
  end

  describe '#add service' do
    it 'can add available services' do
      expect(@facility_1.services).to eq([])
      @facility_1.add_service('New Drivers License')
      @facility_1.add_service('Renew Drivers License')
      @facility_1.add_service('Vehicle Registration')
      expect(@facility_1.services).to eq(['New Drivers License', 'Renew Drivers License', 'Vehicle Registration'])
    end
  end

  describe '#registration_date' do
    it 'date registered' do
      expect(@cruz.registration_date). to be(nil)
    end
  end

  describe '#registered_vehicles' do
    it 'is a list of registered vehicles' do
      expect(@facility_1.registered_vehicles).to eq([])
    end
  end

  describe '#collected_fees' do
    it 'fees collected by dmv facility for registration of vehicle' do
      expect(@facility_1.collected_fees).to eq(0)
    end
  end

  describe '#register_vehicle' do
    it 'adds vehicle to list of registered_vehicles'do
      expect(@facility_1.register_vehicle(@cruz)).to eq([@cruz])
    end
  end

  describe '#new_registration_date' do
    it 'logs the time of vehicle registered' do
      # require 'pry'; binding.pry
      expect(@cruz.new_registration_date).to eq(Date.new(2023, 9, 2))
    end
  end

  describe '#new_registration_date' do
    it 'logs the time of vehicle registered' do
      # require 'pry'; binding.pry
      expect(@cruz.plate_type).to eq(:regular)
    end
  end


end
