module Lookbook
  class ApplicationController < ActionController::Base
    prepend_view_path Engine.root.join("app/components/lookbook")
    prepend_view_path Engine.root.join("app/components/nook")
    content_security_policy(false) if respond_to?(:content_security_policy)

    protect_from_forgery with: :exception

    layout "nook/application"

    helper Lookbook::ClassNamesHelper if Engine.runtime_context.rails_older_than?("6.1.0")
    helper Lookbook::ApplicationHelper
    helper Lookbook::UiElementsHelper
    helper Nook::ComponentHelper

    before_action :assign_theme_overrides
    before_action :assign_instance_vars

    rescue_from ActionController::RoutingError do |err|
      raise Lookbook::RoutingError, err.message, original: err
    end
    rescue_from StandardError, with: :handle_error

    def self.controller_path
      "lookbook"
    end

    def index
      landing = Engine.pages.find(&:landing?) || Engine.pages.first
      if landing.present?
        redirect_to lookbook_page_path(landing.lookup_path)
      else
        render "lookbook/index"
      end
    end

    def not_found
      raise_not_found
    end

    protected

    def assign_theme_overrides
      @theme_overrides ||= Engine.theme.to_css
    end

    def assign_instance_vars
      @previews = Engine.previews
      @pages = Engine.pages
      @theme = Engine.theme
      @config = Lookbook.config
      @engine = Lookbook.engine
      @app = Lookbook
      @embed = !!params[:lookbook_embed]
      @blank_slate = Engine.pages.none? && Engine.previews.none?
    end

    def raise_not_found(message = "Page not found")
      raise Lookbook::RoutingError, message
    end

    def handle_error(err)
      @error = err.is_a?(Lookbook::Error) ? err : Lookbook::Error.new(original: err)
      @status_code = get_status_code(err)

      view = (@status_code == :not_found) ? "not_found" : "default"
      layout = current_layout || "lookbook/skeleton"

      render "lookbook/errors/#{view}", layout: layout, status: @status_code
    end

    def current_layout
      self.class.send(:_layout)
    end

    private

    def get_status_code(err)
      if err.respond_to?(:status)
        err.status
      else
        status_map = ActionDispatch::ExceptionWrapper.rescue_responses
        status_map.fetch(err.class.name, :internal_server_error)
      end
    end
  end
end
