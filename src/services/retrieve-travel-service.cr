require "../models/*"

def retrieveTravelService(id : String)

    travel_plan = Travels.where {_id == id}

    return travel_plan.to_json(only: %w[id travel_stops])
end