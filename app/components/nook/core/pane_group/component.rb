module Nook
  module Core
    class PaneGroup::Component < Nook::BaseComponent
      with_slot :pane, :nook_pane
    end
  end
end
