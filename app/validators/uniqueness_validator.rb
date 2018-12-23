class UniquenessValidator < ActiveRecord::Validations::UniquenessValidator
  def initialize(klass)
    super
    @klass = options[:model] if options[:model]
  end

  def validate_each(record, attribute, value)
    record_org = record
    attribute_org = attribute

    attributes = { attribute => value }
    record = options[:model].new(attributes)

    super

    record_org.errors.add(attribute_org, :not_unique) if record.errors.any?
  end
end
