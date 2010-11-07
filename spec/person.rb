class GenericPerson
  include ActiveModel::Validations
  attr_accessor :primary_email

  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end
end

class Person < GenericPerson
  validates :primary_email, :email => true
end

class PersonMessage < GenericPerson
  validates :primary_email,
            :email => { :message => 'fails with custom message' }
end

class PersonMX < GenericPerson
  validates :primary_email,
            :email => { :mx => true }
end

class PersonMXA < GenericPerson
  validates :primary_email,
            :email => { :mx => { :a_fallback => true } }
end

class PersonMXMessage < GenericPerson
  validates :primary_email,
            :email => { :mx => true,
                        :mx_message => 'fails with custom mx message'}
end
