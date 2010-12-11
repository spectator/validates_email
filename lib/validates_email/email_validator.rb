# Email validation class which uses Rails 3 ActiveModel
# validation mechanism.
#
class EmailValidator < ActiveModel::EachValidator

  LocalPartSpecialChars = Regexp.escape('!#$%&\'*-/=?+-^_`{|}~')
  LocalPartUnquoted = '(([[:alnum:]' + LocalPartSpecialChars + ']+[\.\+]+))*[[:alnum:]' + LocalPartSpecialChars + '+]+'
  LocalPartQuoted = '\"(([[:alnum:]' + LocalPartSpecialChars + '\.\+]*|(\\\\[\x00-\xFF]))*)\"'
  Regex = Regexp.new('^((' + LocalPartUnquoted + ')|(' + LocalPartQuoted + ')+)@(((\w+\-+[^_])|(\w+\.[^_]))*([a-z0-9-]{1,63})\.[a-z]{2,6}(?:\.[a-z]{2,6})?$)', Regexp::EXTENDED | Regexp::IGNORECASE, 'n')

  # Validates email address.
  # If MX fallback was also requested, it will check if email is valid
  # first, and only after that will go to MX fallback.
  #
  # @example
  #   class User < ActiveRecord::Base
  #     validates :primary_email, :email => { :mx => { :a_fallback => true } }
  #   end
  #
  def validate_each(record, attribute, value)
    if validates_email_format(value)
      if options[:mx] && !validates_email_domain(value, options[:mx])
        record.errors[attribute] << (options[:mx_message] || I18n.t(:mx_invalid, :scope => [:activerecord, :errors, :messages]))
      end
    else
      record.errors[attribute] << (options[:message] || I18n.t(:invalid, :scope => [:activerecord, :errors, :messages]))
    end
  end

  private

  # Checks email if it's valid by rules defined in `Regex`.
  #
  # @param [String] A string with email. Local part of email is max 64 chars,
  #   domain part is max 255 chars.
  #
  # @return [Boolean] True or false.
  #
  def validates_email_format(email)
    # TODO: should this decode escaped entities before counting?
    begin
      local, domain = email.split('@', 2)
    rescue NoMethodError
      return false
    end

    email =~ Regex and not email =~ /\.\./ and domain.length <= 255 and local.length <= 64
  end

  # Checks email is its domain is valid. Fallbacks to A record if requested.
  #
  # @param [String] A string with email.
  # @param [Hash] A hash of options, which tells whether to use A fallback or
  #   or not. Additional options can be also passed.
  #
  # @return [Integer, nil] In general, it's true or false.
  #
  def validates_email_domain(email, options)
    require 'resolv'
    a_fallback = options.is_a?(Hash) ? options[:a_fallback] : false
    domain = email.match(/\@(.+)/)[1]
    Resolv::DNS.open do |dns|
      @mx = dns.getresources(domain, Resolv::DNS::Resource::IN::MX)
      @mx.push(*dns.getresources(domain, Resolv::DNS::Resource::IN::A)) if a_fallback
    end
    @mx.size > 0 ? true : false
  end

end
