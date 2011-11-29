# encoding: utf-8

require 'erb'
require 'rpcoder_exporter'
require 'rpcoder/function'
require 'rpcoder/type'

module RPCoder
  class << self
    @templates_path
    @output_path
    def templates_path=(templates_path)
      @templates_path = templates_path
    end
    def output_path=(output_path)
      @output_path = output_path
    end

    def name_space=(name_space)
      @name_space = name_space
    end

    def name_space
      @name_space
    end

    def api_class_name=(name)
      @api_class_name = name
    end

    def api_class_name
      @api_class_name
    end

    def types
      @types ||= []
    end

    def type(name)
      type = Type.new
      type.name = name
      yield type
      types << type
      type
    end

    def functions
      @functions ||= []
    end

    def function(name)
      func = Function.new
      func.name = name
      yield func
      functions << func
      func
    end

    def render_erb(template, _binding)
      ERB.new(File.read(template), nil, '-').result(_binding)
    end

    def template_path(name)
      File.join @templates_path, name + '.erb'
    end

    def clear
      functions.clear
      types.clear
    end
  end
end
