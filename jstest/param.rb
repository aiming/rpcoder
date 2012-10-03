# encoding: utf-8
# js
module RPCoder
  class Param
    def self.original_types
      [:int, :String, :Boolean, :Array, :Hash]
    end

    attr_accessor :name, :type, :options
    def initialize(name, type, options = {})
      @name = name
      @type = type
      @options = options
    end

  end
end
