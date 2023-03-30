module Nook
  module ComponentHelper
    COMPONENT_CLASSES = {}

    def nook_button(href = nil, **kwargs, &block)
      nook_component("core/button", href: href, **kwargs, &block)
    end

    def nook_button_group(**kwargs, &block)
      nook_component("core/button-group", **kwargs, &block)
    end

    def nook_tab(**kwargs, &block)
      nook_component("core/tab", **kwargs, &block)
    end

    def nook_tab_group(name, **kwargs, &block)
      nook_component("core/tab-group", **kwargs, name: name, &block)
    end

    def nook_tab_panel(**kwargs, &block)
      nook_component("core/tab-panel", **kwargs, &block)
    end

    def nook_tab_panel_group(**kwargs, &block)
      nook_component("core/tab-panel-group", **kwargs, &block)
    end

    def nook_pane(**kwargs, &block)
      nook_component("core/pane", **kwargs, &block)
    end

    def nook_pane_group(**kwargs, &block)
      nook_component("core/pane-group", **kwargs, &block)
    end

    def nook_toolbar(**kwargs, &block)
      nook_component("core/toolbar", **kwargs, &block)
    end

    def nook_toolbar_section(**kwargs, &block)
      nook_component("core/toolbar-section", **kwargs, &block)
    end

    def nook_icon(icon_name = nil, **kwargs)
      nook_component("core/icon", name: icon_name, **kwargs)
    end

    def nook_app_header(**kwargs, &block)
      nook_component("app/header", **kwargs, &block)
    end

    def nook_layout(name, **kwargs, &block)
      nook_component("layouts/#{name}", **kwargs, &block)
    end

    def nook_component(name, *args, **kwargs, &block)
      comp = resolve_nook_class(name).new(*args, **kwargs)
      # if defined?(view_context) && view_context
      #   view_context.render comp, &block
      # else
      render comp, &block
      # end
    end

    def resolve_nook_class(*args)
      ref = args.join("/")
      COMPONENT_CLASSES[ref] ||= begin
        klass = ref.to_s.tr("-", "_").camelize
        "Nook::#{klass}::Component".constantize
      end
    end
  end
end
