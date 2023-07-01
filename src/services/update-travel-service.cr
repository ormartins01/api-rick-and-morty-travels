require "../models/*"

def updateTravelService(id : String, update_travel)

    new_update_travel = (update_travel.travel_stops).to_json
  
    travel = Travels.where{_id == id}.update(travel_stops: new_update_travel)
  
    travel_updated = Travels.where{_id == id}

    return travel_updated.to_json(only: %w[id travel_stops])

end