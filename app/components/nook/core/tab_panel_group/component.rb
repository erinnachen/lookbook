module Nook
  module Core
    class TabPanelGroup::Component < Nook::BaseComponent
      with_slot :panel, :nook_tab_panel

      attr_reader :name

      def initialize(name:, **kwargs)
        @name = name
      end
    end
  end
end
