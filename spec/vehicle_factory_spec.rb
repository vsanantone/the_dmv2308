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

end