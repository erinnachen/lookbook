module Nook
  module Core
    class Button::Component < Nook::BaseComponent
      include Concerns::AcceptsOptions

      SIZES = %i[xxs xs sm md lg xl xxl]

      tag_attr :href, :disabled, :type, :value, :name

      accepts_option :size, from: SIZES, default: :md

      with_slot :icon, :nook_icon

      def initialize(icon: nil, label: nil, **kwargs)
        @label = label
        with_icon(icon) if icon
      end

      def tag_name
        tag_attrs[:href].present? ? :a : :button
      end

      def label
        @label unless content.present?
      end
    end
  end
end
