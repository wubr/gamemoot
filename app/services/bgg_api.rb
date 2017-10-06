# frozen_string_literal: true
class BggApi
  BASE_URL = "https://www.boardgamegeek.com/xmlapi2"
  THING_URL = "#{BASE_URL}/thing"

  def game_info(id)
    parsed_resp = parse_response(RestClient.get(THING_URL, params: {id: id, type: "boardgame"}).body)
    {
      name: parsed_resp.at_css('name').try(:[], 'value'),
      min_players: parsed_resp.at_css('minplayers').try(:[], 'value').to_i,
      max_players: parsed_resp.at_css('maxplayers').try(:[], 'value').to_i
    }
  end

  def parse_response(resp)
    Nokogiri::XML.parse(resp)
  end

end