module Nook
  module Layouts
    class App::Component < Nook::BaseComponent
      component_name :app_layout

      with_slot :header, :nook_app_header
    end
  end
end
