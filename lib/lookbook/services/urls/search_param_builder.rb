module Lookbook
  class SearchParamBuilder < Service
    attr_reader :data

    def initialize(data)
      @data = data
    end

    def call
      data.map { |k, v| "#{k}:#{v}" }.join("|")
    end
  end
end
