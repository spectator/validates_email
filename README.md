[![Build
Status](https://secure.travis-ci.org/spectator/validates_email.png?branch=master)](http://travis-ci.org/spectator/validates_email)
[![Dependency
Status](https://gemnasium.com/spectator/validates_email.png?travis)](https://gemnasium.com/spectator/validates_email)

validates_email
===============

validates_email is a Rails plugin that validates email addresses against RFC 2822 and RFC 3696

Installation
------------

    rails plugin install git://github.com/spectator/validates_email.git

or

    gem 'spectator-validates_email', :require => 'validates_email'

Usage
-----

    class User < ActiveRecord::Base
      validates :primary_email, :email => true
    end

As well as any other Rails validation this one has the same triggers, such as `:on`, `:if`, `:unless`, `:allow_blank`, and `:allow_nil`.

Also, you can pass your own custom error message.

    class User < ActiveRecord::Base
      validates :primary_email, :email => { :message => 'is not an email address' }
    end

If you like to check MX Records for email, you can use `:mx` option.

    class User < ActiveRecord::Base
      validates :primary_email, :email => { :mx => true }
    end

And if you like to check MX Records with fallback to A record, use `:a_fallback` option.

    class User < ActiveRecord::Base
      validates :primary_email, :email => { :mx => { :a_fallback => true } }
    end

I18n
----

If you don't specify your own error message, then ActiveRecord's `:invalid` error message will be used to show the error.

If do check MX Records, then you have to specify your own error message or add it to your traslations:

    activerecord:
      errors:
        messages:
          mx_invalid: "is not valid"

Credits
-------

Most of the code were taken from Alex Dunae (dunae.ca) plugin (see http://github.com/alexdunae/validates_email_format_of/) and adopted for Rails 3 playing around with Rails 3 beta, so pass all beers to him.

Contributors
------------

* Petr Blaho
* Christian Eichhorn
* Alexander Zubkov

How to contribute
-----------------

* Fork
* Make changes
* Write specs
* Do pull request

Testing
-------

To execute unit tests run `rake spec` within plugin folder.

The unit tests for this plugin use an in-memory sqlite3 database.

Notes
-----

Compatible with following ruby versions:

* Ruby 1.8.7
* Ruby 1.9.2
* Ruby 1.9.3
