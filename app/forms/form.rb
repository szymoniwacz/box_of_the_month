class Form
  include ActiveModel::Validations
  include ActiveModel::Validations::Callbacks
  extend ActiveModel::Callbacks
  include Virtus.model

  define_model_callbacks :initialize, only: :after

  attr_reader :keys, :objects

  class << self
    def inherited(base)
      super
      base.instance_variable_set(:@subforms, subforms)
    end

    def subforms(*subforms)
      return @subforms if subforms.blank?
      @subforms = [*@subforms, *subforms].uniq
    end

    def validates_subform(*attr_names)
      validates_with RelationValidator, _merge_attributes(attr_names)
    end

    def config(object)
      @settings = object
    end

    def settings
      @settings
    end
  end

  def initialize(attributes = {}, objects = {})
    run_callbacks :initialize do
      @keys = attributes.keys.map(&:to_sym)
      @objects = objects
      super(attributes)
    end
  end

  def to_hash
    return super if subforms.blank?
    super.except(*subforms).merge(subform_hash.compact)
  end

  def attributes
    return super if subforms.blank?
    super.except(*subforms).merge(subform_attributes.compact)
  end

  def subforms
    self.class.subforms
  end

  def subform_attributes
    Hash[
      subforms.map do |subform|
        form_object = method(subform).call
        if form_object.respond_to?(:map)
          [:"#{subform}", form_object.map(&:attributes).presence]
        else
          [:"#{subform}", form_object.try(:attributes)]
        end
      end
    ]
  end

  def subform_hash
    Hash[
      subforms.map do |subform|
        form_object = method(subform).call
        if form_object.respond_to?(:map)
          [:"#{subform}_attributes", form_object.map(&:to_hash).presence]
        else
          [:"#{subform}_attributes", form_object.try(:to_hash)]
        end
      end
    ]
  end
end
