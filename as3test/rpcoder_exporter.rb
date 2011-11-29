module RPCoder
  class << self
    def export()
      class_dir = dir_to_export_classes(@output_path)
      FileUtils.mkdir_p(class_dir)

      [
        {:path => File.join(class_dir, api_class_name.split('.').last + "Interface.as"), :content => render_functions_interface},
        {:path => File.join(class_dir, api_class_name.split('.').last + ".as"), :content => render_functions},
        {:path => File.join(class_dir, api_class_name.split('.').last + "Dummy.as"), :content => render_functions_dummy},
      ].each do |hash|
        puts "API: #{hash[:path]}"
        File.open(hash[:path], "w") { |file| file << hash[:content] }
      end
      types.each { |type| export_type(type, File.join(class_dir, "#{type.name}.as")) }
    end

    def render_functions_interface
      render_erb(template_path('APIInterface'), binding)
    end

    def render_functions
      render_erb(template_path('API'), binding)
    end

    def render_functions_dummy
      render_erb(template_path('APIDummy'), binding)
    end

    def export_type(type, path)
      puts "Type: #{path}"
      File.open(path, "w") { |file| file << render_type(type) }
    end

    def render_type(type)
      render_erb(template_path('Type'), binding)
    end

    def dir_to_export_classes(dir)
      File.join(dir, *name_space.split('.'))
    end
  end
end
