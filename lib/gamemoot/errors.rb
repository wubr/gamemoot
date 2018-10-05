# frozen_string_literal: true

module Gamemoot
  module Errors
    class BggApiError < StandardError; end
    class BggGameInfoNotFound < RuntimeError; end
  end
end
