require 'singleton'

module Pivotal
  class Connection
    include Singleton

    HOST        = 'https://www.pivotaltracker.com'
    EMAIL       = ENV['PIVOTAL_EMAIL']
    PASSWORD    = ENV['PIVOTAL_PASSWORD']
    PERSON_ID   = ENV['PIVOTAL_PERSON_ID']
    PROJECT_ID  = ENV['PIVOTAL_PROJECT_ID']
    COOKIE_FILE = 'pivotal_session.txt'

    attr_accessor :email, :password, :logged_in

    def initialize
      @logged_in = false
    end

    def login
      `curl -c #{COOKIE_FILE} -d 'credentials[username]=#{EMAIL}&credentials[password]=#{PASSWORD}' #{HOST}/signin` unless @logged_in
      @logged_in = true
    end

    def post_form(data, path)
      login unless @logged_in
      `curl -b #{COOKIE_FILE} -c #{COOKIE_FILE} -d '#{data}' #{HOST}/#{path}`
    end
  end
end
