require "../services/*"

def updateTravelController(id : String, update_travel)

    travel = updateTravelService(id, update_travel)

    return travel
end