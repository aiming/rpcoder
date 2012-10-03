# encoding: utf-8
# js rpcoder
module RPCoder
  class << self
    def export()
      # Api毎にファイル化する ---------------------------------------------
      erb_name = 'Api'
      parent_path = 'app/assets/javascripts/apis'

      functions.each do |func|
        dir_path     = File.join(@output_path, parent_path)     # 出力先パスを生成する
        FileUtils.mkdir_p(dir_path)                             # 出力先ディレクトリがなければ作成する

        file_path = File.join(dir_path, func.name.downcase + "_api.js.coffee")
        puts "Api #{erb_name} : #{file_path}"
        File.open(file_path, "w") do |file| file << render_function(func, erb_name) end
      end

    end

    # function用のファイル生成
    def render_function(func, erb_name)
      render_erb(template_path("#{erb_name}"), binding)
    end
  end
end
