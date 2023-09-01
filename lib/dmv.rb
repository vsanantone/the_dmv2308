class Dmv
  attr_reader :facilities#bug5 no attr_reader

  def initialize
    @facilities = []
  end

  def add_facility(facility)
    @facilities << facility
  end

  def facilities_offering_service(service)
    @facilities.find_all do |facility| #bug6 switch the find to find_all method
      facility.services.include?(service)
    end
  end
end
