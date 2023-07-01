require "json"
require "kemal"
require "jennifer"
require "./utils/*"
require "./models/*"
require "../config/*"
require "./controllers/*"
require "./middlewares/*"

class Info
  include JSON::Serializable

  property count : Int32
  property pages : Int32
  property next : String
  property results : String?
end


class TravelRequest
  include JSON::Serializable
  property travel_stops : Array(Int32)
end


class ResponseApi
  include JSON::Serializable

  property info : Info
  property results : Array(Results)
end


post "/travel_plans" do |env|
  travel = TravelRequest.from_json env.request.body.not_nil!

  travel_exist = verifyTravelMiddleware(travel)

  if travel_exist
    new_travel = createTravelController(travel)
    env.response.status_code = 201
  
    new_travel
  else
    env.response.status_code = 400
  end
end

get "/travel_plans" do |env|

  travels_list = allTravelsController()

  travels_list
end

get "/travel_plans/:id" do |env|
  id = env.params.url["id"]
  expand = env.params.query["expand"]?
  optimize = env.params.query["optimize"]?

  travel_exist = idVerifyMiddleware(id)

  if travel_exist
    travel = retrieveTravelController(id)
    if expand
      arr_stops = travel["travel_stops"]
      expanded_stops = sourceWorlds(arr_stops)
      travel_expanded_stops = {
        id: id.to_i,
        travel_stops: expanded_stops
      }
      env.response.content_type = "application/json"

      travel_expanded_stops.to_json

    end
    if optimize
      travel_stops = travel["travel_stops"]
      # optimize_travel_stops = orderWorlds(travel_stops)
      # travel.travel_stops = optimize_travel_stops
    end

    travel
  else
    env.response.status_code = 404
  end

end

put "/travel_plans/:id" do |env|

  id = env.params.url["id"].to_s

  travel_exist = idVerifyMiddleware(id)

  if travel_exist
    update_travel = TravelRequest.from_json env.request.body.not_nil!
    updated_travel = updateTravelController(id, update_travel)
    updated_travel
  else
    env.response.status_code = 404
  end
end

delete "/travel_plans/:id" do |env|

  id = env.params.url["id"].to_s

  travel_exist = idVerifyMiddleware(id)

  if travel_exist
    deleteTravelController(id)
    env.response.status_code = 204
  else
    env.response.status_code = 404
  end
end


error 400 do |env|
  env.response.content_type = "application/json"
  {message: "bad_request"}.to_json
end

error 404 do |env|
  env.response.content_type = "application/json"
  {message: "not_found"}.to_json
end

Kemal.run