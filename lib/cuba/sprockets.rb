require 'sprockets'

module Cuba::Sprockets
  def self.setup(app)
    app.settings[:sprockets] ||= {}
    app.settings[:sprockets][:path] ||= '/assets'
    app.settings[:sprockets][:assets_path] ||= File.join Dir.pwd, 'assets'
    app.settings[:sprockets][:manifest_path] ||= File.join Dir.pwd, 'public', 'assets'
    app.settings[:sprockets][:fonts_path] ||= File.join app.settings[:sprockets][:assets_path], 'fonts'
    app.settings[:sprockets][:images_path] ||= File.join app.settings[:sprockets][:assets_path], 'images'
    app.settings[:sprockets][:javascripts_path] ||= File.join app.settings[:sprockets][:assets_path], 'javascripts'
    app.settings[:sprockets][:stylesheets_path] ||= File.join app.settings[:sprockets][:assets_path], 'stylesheets'
  end

  def asset_path(file)
    if ENV['RACK_ENV'] == 'production'
      manifest = ::Sprockets::Manifest.new settings[:sprockets][:manifest_path]
      "#{settings[:sprockets][:path]}/#{manifest.assets[file]}"
    else
      "#{settings[:sprockets][:path]}/#{file}"
    end
  end

  def sprockets
    @sprockets ||= ::Sprockets::Environment.new do |env|
      env.append_path settings[:sprockets][:fonts_path]
      env.append_path settings[:sprockets][:images_path]
      env.append_path settings[:sprockets][:javascripts_path]
      env.append_path settings[:sprockets][:stylesheets_path]
    end
  end
end
