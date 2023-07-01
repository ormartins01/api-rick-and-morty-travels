require "../models/*"

def idVerifyMiddleware(id)

    travel = Travels.where{_id == id}.exists?

    return travel

end