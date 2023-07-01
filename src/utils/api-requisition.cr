require "json"
require "http"

class Results
    include JSON::Serializable
    
    property id : Int32 = 0
    property name : String = ""
    property type : String = ""
    property dimension : String = ""
  end

  def apiResults

    url = "https://rickandmortyapi.com/api/location"

    results_api = [] of Results
    
    info_api = "TESTE"

    response = HTTP::Client.get(url)
    json_data = JSON.parse(response.body.to_s)
    info_api = json_data["info"]
    
    page = 1

    str_lastpage = info_api["pages"].to_s
    
    int_lastpage = str_lastpage.to_i
    
    while page <= int_lastpage

      page_response = HTTP::Client.get(url + "?page=#{page}")
      page_json_data = JSON.parse(page_response.body)
      results = page_json_data["results"]

      results_index = 0

      while results_index < results.size
        world = results[results_index]

        results_api << Results.from_json(world.to_json)

        results_index += 1
      end

      page += 1
    end
    return results_api.to_json
  end  
