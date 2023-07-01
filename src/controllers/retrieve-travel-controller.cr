require "../services/*"

def retrieveTravelController(id : String)

    travel_plan = retrieveTravelService(id)

    return travel_plan
end