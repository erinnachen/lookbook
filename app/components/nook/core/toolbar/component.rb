module Nook
  module Core
    class Toolbar::Component < Nook::BaseComponent
      with_slot :section, :nook_toolbar_section
    end
  end
end
