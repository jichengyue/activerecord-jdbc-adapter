warn "Jdbc-Derby is only for use with JRuby" if (JRUBY_VERSION.nil? rescue true)

module Jdbc
  module Derby
    DRIVER_VERSION = "10.9.1.0"
    VERSION = DRIVER_VERSION + ''

    def self.driver_jar
      "derby-#{DRIVER_VERSION}.jar"
    end

    def self.load_driver(method = :load)
      send method, driver_jar
    end

    def self.driver_name
      'org.apache.derby.jdbc.EmbeddedDriver'
    end

    if defined?(JRUBY_VERSION) && # enable backwards-compat behavior :
      ( Java::JavaLang::Boolean.get_boolean("jdbc.driver.autoload") || 
        Java::JavaLang::Boolean.get_boolean("jdbc.derby.autoload") )
      warn "autoloading JDBC driver on require 'jdbc/derby'" if $VERBOSE
      load_driver :require
    end
  end
end
