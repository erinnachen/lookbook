module Nook
  module App
    class Header::Component < Nook::AppComponent
      def home_path
        helpers.lookbook_landing_path if defined? helpers.lookbook_landing_path
      end

      def debug_data
        JSON.pretty_generate(app.debug_data)
      end
    end
  end
end
