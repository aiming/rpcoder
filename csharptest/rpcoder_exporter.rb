# csharp rpcoder
module RPCoder
  class << self
    @@templates = ["API", "Interface", "Dummy", "DummyServer", "Extentions"]
    @@extra_templates = []

    def export()
      class_dir = dir_to_export_classes(@output_path)
      FileUtils.mkdir_p(class_dir)
      @@templates.map { |name|
        create_binding(name)
      }.concat(@@extra_templates).each do |hash|
        path = get_export_file_name(class_dir, hash[:path])
        puts "API: #{path}"
        File.open(path, "w") { |file| file << render_erb(hash[:template], binding) }
      end
      types.each { |type| export_type(type, 'Type', File.join(class_dir, "#{type.name}.cs")) }
      types.each { |type| export_type(type, 'TypeJson', File.join(class_dir, "#{type.name}.json.cs")) }
    end

    def create_binding(name)
      {:path => name, :template => template_path(name) }
    end

    def get_export_file_name(class_dir, name)
      File.join(class_dir, api_class_name.split('.').last + name + ".cs")
    end

    def export_type(type, template_name, path)
      puts "Type: #{path}"
      File.open(path, "w") { |file| file << render_type(type, template_name) }
    end

    def render_type(type, template_name)
      render_erb(template_path(template_name), binding)
    end

    def dir_to_export_classes(dir)
      File.join(dir, *name_space.split('.'))
    end

#     def add_template(item_name, template_path)
#       @@extra_templates << {:path => item_name, :template => template_path}
#     end
  end
end
