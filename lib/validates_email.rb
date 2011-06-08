require "validates_email/email_validator"

if RUBY_VERSION.to_f < 1.9
  class Encoding
    class CompatibilityError < StandardError; end
  end
end
