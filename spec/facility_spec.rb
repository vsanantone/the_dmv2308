require 'spec_helper'

RSpec.describe Facility do
  before(:each) do
    @facility_1 = Facility.new({name: 'DMV Tremont Branch', address: '2855 Tremont Place Suite 118 Denver CO 80205', phone: '(720) 865-4600'})
    @facility_2 = Facility.new({name: 'DMV Northeast Branch', address: '4685 Peoria Street Suite 101 Denver CO 80239', phone: '(720) 865-4600'})
    
    @cruz = Vehicle.new({vin: '123456789abcdefgh', year: 2012, make: 'Chevrolet', model: 'Cruz', engine: :ice} )
    @bolt = Vehicle.new({vin: '987654321abcdefgh', year: 2019, make: 'Chevrolet', model: 'Bolt', engine: :ev} )
    @camaro = Vehicle.new({vin: '1a2b3c4d5e6f', year: 1969, make: 'Chevrolet', model: 'Camaro', engine: :ice} )
    
    @registrant_1 = Registrant.new('Bruce', 18, true)
    @registrant_2 = Registrant.new('Penny', 16 )
    @registrant_3 = Registrant.new('Tucker', 15 )
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
      expect(@cruz.new_registration_date).to eq(@cruz.new_registration_date)#check this out soon
    end
  end

  describe '#plate_type' do
    it 'returns plate_type category' do
      # require 'pry'; binding.pry
      expect(@cruz.plate_type).to eq(:regular)
    end
  end

  describe '#collected_fees'do
    it 'collects car registration fees' do
      expect(@facility_1.register_vehicle(@cruz)).to eq([@cruz])
      expect(@facility_1.registered_vehicles).to eq([@cruz])
      expect(@facility_1.rcollected_fees(@cruz)).to eq(100)
    
      expect(@facility_1.register_vehicle(@camaro)).to eq([@cruz, @camaro])
      expect(@camaro.new_registration_date).to eq(@camaro.new_registration_date)#check this out soon
      expect(@facility_1.registered_vehicles).to eq([@cruz, @camaro])
      expect(@facility_1.rcollected_fees(@camaro)).to eq(125) 
      expect(@camaro.plate_type).to eq(:antique)

      expect(@facility_1.register_vehicle(@bolt)).to eq([@cruz, @camaro, @bolt])
      expect(@bolt.new_registration_date).to eq(@bolt.new_registration_date)#check this out soon
      expect(@bolt.plate_type).to eq(:ev)
      expect(@facility_1.registered_vehicles).to eq([@cruz, @camaro, @bolt])
      expect(@facility_1.rcollected_fees(@bolt)).to eq(325) 
    end

    it ' registeres vehicles in the 2nd facility' do
      expect(@facility_2.registered_vehicles).to eq([])
      expect(@facility_2.services).to eq([])
      expect(@facility_2.collected_fees).to eq(0) 
      @facility_2.register_vehicle(@bolt)#interaction pattern says nil
      expect(@facility_2.registered_vehicles).to eq([@bolt])
      expect(@facility_2.rcollected_fees(@bolt)).to eq(200) 
    end
  end

  describe "written test" do
    it "gives exam to registrant" do
      expect(registrant_1.license_data).to eq({:written=>false, :license=>false, :renewed=>false})
      expect(registrant_1.permit?).to eq(true)
      expect(@facility_1.administer_written_test(registrant_1)).to eq(false)
      expect(@registrant_1.license_data).to eq({:written=>false, :license=>false, :renewed=>false})
      @facility_1.add_service('Written Test')
      expect(@facility_1.administer_written_test(registrant_1)).to eq(true)
      expect(@registrant_1.license_data).to eq({:written=>true, :license=>false, :renewed=>false})

      expect(@registrant_2.age).to eq(16)
      expect(@registrant_2.permit?).to eq(false)
      expect(@facility_1.administer_written_test(registrant_2)).to eq(false)
      @registrant_2.earn_permit
      expect(@facility_1.administer_written_test(registrant_2)).to eq(true)
      expect(@registrant_2.license_data).to eq({:written=>true, :license=>false, :renewed=>false})
      
      expect(@registrant_3.age).to eq(15)
      expect(@registrant_3.permit?).to eq(false)
      expect(@facility_1.administer_written_test(registrant_3)).to eq (false)
      @registrant_3.earn_permit
      expect(@facility_1.administer_written_test(registrant_3)).to eq (false)
      expect(@registrant_3.license_data).to eq({:written=>false, :license=>false, :renewed=>false})
    end
  end

  describe "Road Test" do
    it "Road Test to registrant" do 
      @facility_1.add_service('Written Test')
      @registrant_2.earn_permit
      @facility_1.administer_written_test(registrant_2)
      @facility_1.administer_written_test(registrant_1)
      
      expect(@facility_1.administer_road_test(registrant_3)).to eq (false)
      @registrant_3.earn_permit
      expect(@facility_1.administer_road_test(registrant_3)).to eq(false)
      expect(@registrant_3.license_data).to eq({:written=>false, :license=>false, :renewed=>false})
      
      expect(@facility_1.administer_road_test(registrant_1)).to eq(false)
      expect(@facility_1.add_service('Road Test')).to eq(["Written Test", "Road Test"])
      expect(@facility_1.administer_road_test(registrant_1)).to eq(true)
      expect(registrant_1.license_data).to eq({:written=>true, :license=>true, :renewed=>false})
      expect(@facility_1.administer_road_test(registrant_2)).to eq (true)
      expect(registrant_2.license_data).to eq({:written=>true, :license=>true, :renewed=>false})
    end
  end
end
