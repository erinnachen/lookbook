module Nook
  class ComponentOption
    attr_accessor :default
    attr_reader :from, :name

    def initialize(name, required: false, value: :undefined, from: nil, **kwargs)
      @name = name.to_sym
      @required = required
      @value = value
      @from = Array(from)
      @private = kwargs.fetch(:private, false)
      @default = kwargs.fetch(:default, nil)
      @alias = kwargs.fetch(:alias, nil)
    end

    def alias
      @alias || name
    end

    def html_alias
      self.alias.to_s.tr("_", "-")
    end

    def private?
      @private == true
    end

    def public?
      !private?
    end

    def validate_required!
      if required? && undefined?
        raise ArgumentError, "The `#{name}` option requires a value"
      end
    end

    def required?
      @required == true
    end

    def undefined?
      @value == :undefined
    end

    def value
      undefined? ? default : @value
    end

    def value=(val)
      if from.any? && !from.include?(val)
        raise ArgumentError, "`#{val}` is not a valid #{name} value.\n\tAvailable options: #{from}"
      end
      @value = val
    end

    def to_h
      h = {
        name: name,
        alias: @alias,
        required: required?,
        private: private?,
        from: from,
        default: default
      }
      h[:value] = @value unless undefined?
      h
    end

    class << self
      def new(arg, **opts)
        arg.is_a?(self) ? arg : super(arg, **opts)
      end
    end
  end
end
