require "../models/*"

def verifyTravelMiddleware(travel)

    travel_stops_exists = travel.travel_stops

    if travel_stops_exists.is_a?(Array(Int32))
        return true
    else
        return false
    end

end