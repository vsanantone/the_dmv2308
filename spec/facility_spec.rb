require 'spec_helper'

RSpec.describe Facility do
  before(:each) do
    @facility1 = Facility.new({name: 'DMV Tremont Branch', address: '2855 Tremont Place Suite 118 Denver CO 80205', phone: '(720) 865-4600'})
  end
  describe '#initialize' do
    it 'can initialize' do
      expect(@facility1).to be_an_instance_of(Facility)
      expect(@facility1.name).to eq('DMV Tremont Branch')
      expect(@facility1.address).to eq('2855 Tremont Place Suite 118 Denver CO 80205')
      expect(@facility1.phone).to eq('(720) 865-4600')
      expect(@facility1.services).to eq([])
    end
  end

  describe '#add service' do
    it 'can add available services' do
      expect(@facility1.services).to eq([])
      @facility1.add_service('New Drivers License')
      @facility1.add_service('Renew Drivers License')
      @facility1.add_service('Vehicle Registration')
      expect(@facility1.services).to eq(['New Drivers License', 'Renew Drivers License', 'Vehicle Registration'])
    end
  end


end
