require "../models/*"

def createTravelService(travel)
    json_travel = (travel.travel_stops).to_json

    new_travel = Travels.create({travel_stops: json_travel})

    new_travel.save

    return  new_travel.to_json(only: %w[id travel_stops])

end