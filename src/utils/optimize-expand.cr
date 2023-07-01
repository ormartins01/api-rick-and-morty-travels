require "./api-requisition"


def sourceWorlds(arr_stops)

    url = "https://rickandmortyapi.com/api/location/"

    stops_index = 0
    worlds_index = 0

    new_arr_stops = [] of Results

    while stops_index < arr_stops.size
        stop = arr_stops[stops_index]
        response = HTTP::Client.get(url + "#{stop}")
        json_data = JSON.parse(response.body)

        new_arr_stops << Results.from_json(json_data.to_json)

        stops_index += 1
    end

        return new_arr_stops.to_json
    end
