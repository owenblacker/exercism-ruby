class LocomotiveEngineer
  def self.generate_list_of_wagons(*wagons)
    return wagons
  end

  def self.fix_list_of_wagons(each_wagons_id, missing_wagons)
    move_to_end1, move_to_end2, loco, *existing_wagons = each_wagons_id
    
    return loco, *missing_wagons, *existing_wagons, move_to_end1, move_to_end2
  end

  def self.add_missing_stops(termini, **stops)
    return { **termini, stops: stops.values }
  end

  def self.extend_route_information(route, more_route_information)
    return { **route, **more_route_information }
  end
end
