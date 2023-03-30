module Nook
  module Core
    class TabGroup::Component < Nook::BaseComponent
      with_slot :tab do |*args, **kwargs, &block|
        nook_tab(**kwargs, x: {bind: "root"}, &block)
      end

      attr_reader :name

      def initialize(name:, **kwargs)
        @name = name
      end
    end
  end
end
