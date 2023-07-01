require "../models/*"

def allTravelsServices()
    travels_list = [] of Travels

    travels_list = Travels.all.where{_id > 0}

    return travels_list.to_json(only: %w[id travel_stops])
  
end
