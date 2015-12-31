require 'active_support/core_ext/hash'
require 'json'

class Curl
  attr_accessor :path, :data, :type

  def get_type
    print "Type of request: "
    @type = gets.chomp
  end

  def get_path
    print "Path: "
    @path = gets.chomp
  end

  def get_data
    print "Data: "
    @data = gets.chomp
  end
end

# -----------------------------------------------------------------------------

class Generator
  attr_accessor :curl, :cmd, :request, :user, :domain, :data, :format

  def initialize(curl)
    @curl    = curl
    @cmd     = "curl -i -X"
    @user    = "-u user:userpass"   # Auth data
    @domain  = "http://domain.test" # Modify in need it!
    @request = curl.type.upcase
  end

  def generate
    %w(json xml).each do |f|
      @format = f

      # Output
      puts "\n#{@format.upcase}:\n"
      result = "#{cmd} #{request} #{user} #{gen_headers} #{gen_path} #{gen_data}"
      puts "#{result}\n"
    end
  end

  private

  # gen = generate
  def gen_headers
    "-H 'Accept: application/#{format}' -H 'Content-Type: application/#{format}'"
  end

  def gen_path
    "#{domain}#{curl.path}.#{format}"
  end

  def gen_data
    curl.data == '' ?  nil : "-d '#{format_data}'"
  end

  def format_data
    return if curl.data == ''

    if format == 'xml'
      hash = JSON.parse(curl.data)
      hash.to_xml(skip_instruct: true, skip_types: true).delete("\n ").gsub("<hash>","").gsub("</hash>","")
    else
      curl.data
    end
  end
end

# -----------------------------------------------------------------------------

class Run
  class << self
    attr_accessor :curl, :test

    def exec
      puts "CURL Generator v0.2 beta"

      curl = Curl.new
      curl.get_type
      curl.get_path
      curl.get_data

      ask_testing

      g = Generator.new(curl)
      g.generate

      return unless test?

      puts "\n TESTING:"
      system(result)
      puts "\n\n"
    end

    private

    def test?
      test == 'y'
    end

    def ask_testing
      print "Test request (y/n): "
      test = gets.chomp
    end
  end
end

# Go!
Run.exec
