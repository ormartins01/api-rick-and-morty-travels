require "../models/*"

def deleteTravelService(id)

    travel = Travels.delete(id)

    return
end
