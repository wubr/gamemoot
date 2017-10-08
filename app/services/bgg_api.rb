# frozen_string_literal: true

# Responsible for knowing how to talk with BGG
class BggApi
  BASE_URL = 'https://www.boardgamegeek.com/xmlapi2'
  THING_URL = "#{BASE_URL}/thing"
  SEARCH_URL = "#{BASE_URL}/search"

  def self.game_info(id)
    parsed_resp = get_response(THING_URL, id: id, type: 'boardgame')
    return nil unless response_contains_item_nodes(parsed_resp)
    {
      name: field_value(parsed_resp, 'name'),
      min_players: field_value(parsed_resp, 'minplayers').to_i,
      max_players: field_value(parsed_resp, 'maxplayers').to_i
    }
  end

  def self.game_search(query_hash)
    parsed_resp = parse_response(RestClient.get(SEARCH_URL,
                                                params: { query: query_hash[:name],
                                                          type: query_hash.fetch(:type, 'boardgame') }).body)
    parsed_resp.css('item').map do |item|
      {
        name: field_value(item, 'name'),
        bgg_game_id: item['id'],
        published: field_value(item, 'yearpublished')
      }
    end
  end

  def self.field_value(parsed_resp, field)
    parsed_resp.at_css(field).try(:[], 'value')
  end

  def self.get_response(url, params)
    parse_response(RestClient.get(url, params: params).body)
  rescue SocketError, RestClient::ExceptionWithResponse => error
    Rails.logger.error "Error during BggApi::get_response(#{url}, #{params}): #{error}"
    nil
  end

  def self.parse_response(resp)
    Nokogiri::XML.parse(resp)
  end

  def self.response_contains_item_nodes(resp)
    return false unless resp
    resp.at_css('items').css('item').count.positive?
  end
end
