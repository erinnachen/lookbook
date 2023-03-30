module Nook
  class Tag < Nook::Component
    include ActionView::Helpers::TagHelper

    SELF_CLOSING_TAGS = %i[area base br col embed hr img input link meta param source track wbr].freeze

    attr_reader :tag_name

    def initialize(tag_name = :div, **tag_attrs)
      @tag_name = tag_name
      @tag_attrs = tag_attrs
    end

    def call
      if SELF_CLOSING_TAGS.include?(@tag_name)
        tag(tag_name, tag_attrs)
      else
        content_tag(tag_name, content, tag_attrs)
      end
    end

    def tag_attrs
      attrs = @tag_attrs.except(:x, :test_data)
      attrs[:data] = sort_attrs(attrs[:data])

      alpine_attrs = prefix_keys(@tag_attrs.fetch(:x, {}), "x")
      attrs.merge!(sort_attrs(alpine_attrs))

      test_attrs = prefix_keys(@tag_attrs.fetch(:test_data, {}), "test")
      attrs.merge!(sort_attrs(test_attrs))

      attrs
    end

    private

    def prefix_keys(attrs, prefix)
      attrs.transform_keys! { [prefix, _1].map(&:to_s).join("-").tr("_", "-") }
    end

    def sort_attrs(attrs)
      attrs.is_a?(Hash) ? attrs.map { [_1.to_s, _2] }.sort.to_h : attrs
    end
  end
end
