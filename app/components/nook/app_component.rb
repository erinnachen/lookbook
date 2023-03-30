module Nook
  class AppComponent < Nook::BaseComponent
    attr_reader :app

    before_initialize do |**kwargs|
      puts "---------------------- asdasdasd"
      # @app = app
    end

    def config
      {}
      # app.config
    end
  end
end
