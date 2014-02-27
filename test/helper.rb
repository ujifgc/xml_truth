require 'rubygems'
require 'minitest/autorun'
require 'minitest/benchmark'

require 'hpricot'
require 'libxml'
require 'nokogiri'
require 'ox'
require 'rexml/document'

ASSETS  = File.expand_path(File.join(File.dirname(__FILE__), 'assets'))

puts
puts "Hpricot: #{Gem.loaded_specs["hpricot"].version}"
puts "LibXML: #{LibXML::XML::VERSION}"
puts "Nokogiri: #{Nokogiri::VERSION}"
puts "Ox: #{Ox::VERSION}"
puts "Rexml: #{REXML::VERSION}"
puts

class ColoredIO
  def initialize(io)
    @io = io
  end

  def print(o)
    super unless o == "S"
  end

  def puts(*o)
    super
  end
end

MiniTest::Unit.output = ColoredIO.new(MiniTest::Unit.output)
