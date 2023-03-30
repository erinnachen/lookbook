module Nook
  module Core
    class ButtonGroup::Component < Nook::BaseComponent
      include Concerns::AcceptsOptions

      SIZES = Nook::Core::Button::Component::SIZES

      accepts_option :size, from: SIZES, default: :md

      with_slot :button do |*args, **kwargs, &block|
        nook_button(*args, **kwargs, size: get_option_value(:size), &block)
      end
    end
  end
end
