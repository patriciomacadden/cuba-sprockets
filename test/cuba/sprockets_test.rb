require 'helper'

scope Cuba::Sprockets do
  setup do
    @app = Cuba.new
  end

  scope '::setup' do
    test 'default values' do
      assert @app.settings[:sprockets][:path] == '/assets'
      assert @app.settings[:sprockets][:assets_path] == File.join(Dir.pwd, 'assets')
      assert @app.settings[:sprockets][:manifest_path] == File.join(Dir.pwd, 'public', 'assets')
      assert @app.settings[:sprockets][:fonts_path] == File.join(@app.settings[:sprockets][:assets_path], 'fonts')
      assert @app.settings[:sprockets][:images_path] == File.join(@app.settings[:sprockets][:assets_path], 'images')
      assert @app.settings[:sprockets][:javascripts_path] == File.join(@app.settings[:sprockets][:assets_path], 'javascripts')
      assert @app.settings[:sprockets][:stylesheets_path] == File.join(@app.settings[:sprockets][:assets_path], 'stylesheets')
    end

    test 'override default values' do
      Cuba.settings[:sprockets][:path] = '/stessa'
      assert @app.settings[:sprockets][:path] == '/stessa'
      # revert the setting
      Cuba.settings[:sprockets][:path] = '/assets'
    end
  end

  scope '#asset_path' do
    scope 'when RACK_ENV=production' do
      test 'returns the path to the file' do
        ENV['RACK_ENV'] = 'production'
        @app.settings[:sprockets][:manifest_path] = File.join(Dir.pwd, 'test', 'fixtures', 'manifest.json')
        assert '/assets/application-8dbe1c9019cacfa4af55c075d9c32b59dc0885212a00500ad08eb94001f5764a.css' == @app.asset_path('application.css')
        ENV['RACK_ENV'] = 'test'
        @app.settings[:sprockets][:manifest_path] = File.join(Dir.pwd, 'public', 'assets')
      end
    end

    scope 'when RACK_ENV=staging' do
      test 'returns the path to the file' do
        ENV['RACK_ENV'] = 'staging'
        @app.settings[:sprockets][:manifest_path] = File.join(Dir.pwd, 'test', 'fixtures', 'manifest.json')
        assert '/assets/application-8dbe1c9019cacfa4af55c075d9c32b59dc0885212a00500ad08eb94001f5764a.css' == @app.asset_path('application.css')
        ENV['RACK_ENV'] = 'test'
        @app.settings[:sprockets][:manifest_path] = File.join(Dir.pwd, 'public', 'assets')
      end
    end

    scope 'when RACK_ENV=development (or test)' do
      test 'returns the path to the file' do
        assert '/assets/application.css' == @app.asset_path('application.css')
      end
    end
  end

  scope '#sprockets' do
    test 'returns a configured Sprockets::Environment instance' do
      assert @app.sprockets.instance_of?(Sprockets::Environment)
    end
  end
end
