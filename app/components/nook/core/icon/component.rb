module Nook
  module Core
    class Icon::Component < Nook::BaseComponent
      include Concerns::AcceptsOptions

      ICON_CACHE = {}

      InvalidIconError = Class.new(StandardError)

      accepts_option :size, from: %i[xxs xs sm md lg xl xxl]
      accepts_option :spin, from: [true, false]
      accepts_option :style, from: [:line, :fill]

      def initialize(name:, **kwargs)
        @icon_name = name.to_s.tr("_", "-")
        set_tag_data_attr(:icon, @icon_name)
      end

      def svg
        ICON_CACHE[@icon_name] ||= read_svg
      end

      def read_svg
        File.read(svg_path).html_safe
      rescue
        if Rails.env.development? || Rails.env.test?
          raise InvalidIconError, "`#{@icon_name}` is not a valid icon name"
        end
      end

      def svg_path
        Lookbook::Engine.root.join("assets/icons/#{@icon_name}.svg")
      end
    end
  end
end
