# frozen_string_literal: true

module SpecSupport
  module RequestHelpers
    class RequestSeriesResult
      attr_reader :current_time
      attr_reader :request
      attr_reader :response

      def initialize(current_time, request, response)
        @current_time = current_time
        @request      = request
        @response     = response
      end
    end

    def make_request(method, path, options = {})
      send(method, path, options)
    end

    def make_request_series(count, method, path, options = {})
      [].tap do |request_results|
        count.times do |current_time|
          make_request(method, path, options)

          request_results << RequestSeriesResult.new(
            current_time,
            last_request,
            last_response
          )
        end
      end
    end
  end
end
