class EmailValidator < ActiveModel::EachValidator

  LocalPartSpecialChars = Regexp.escape('!#$%&\'*-/=?+-^_`{|}~')
  LocalPartUnquoted = '(([[:alnum:]' + LocalPartSpecialChars + ']+[\.\+]+))*[[:alnum:]' + LocalPartSpecialChars + '+]+'
  LocalPartQuoted = '\"(([[:alnum:]' + LocalPartSpecialChars + '\.\+]*|(\\\\[\x00-\xFF]))*)\"'
  Regex = Regexp.new('^((' + LocalPartUnquoted + ')|(' + LocalPartQuoted + ')+)@(((\w+\-+[^_])|(\w+\.[^_]))*([a-z0-9-]{1,63})\.[a-z]{2,6}$)', Regexp::EXTENDED | Regexp::IGNORECASE, 'n')

  def validates_email_format(email)
    # local part max is 64 chars, domain part max is 255 chars
    # TODO: should this decode escaped entities before counting?
    begin
      local, domain = email.split('@', 2)
    rescue NoMethodError
      return false
    end

    email =~ Regex and not email =~ /\.\./ and domain.length <= 255 and local.length <= 64
  end

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

  def validate_each(record, attribute, value)
    unless validates_email_format(value)
      record.errors[attribute] << (options[:message] || I18n.t(:invalid, :scope => [:activerecord, :errors, :messages]))
    end
    if options[:mx] && !validates_email_domain(value, options[:mx])
      record.errors[attribute] << (options[:mx_message] || I18n.t(:mx_invalid, :scope => [:activerecord, :errors, :messages]))
    end
  end

end
