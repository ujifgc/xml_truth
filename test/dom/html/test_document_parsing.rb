require 'helper'

class C1HTMLParse < MiniTest::Unit::TestCase
  def self.bench_range
    bench_exp 1, 100
  end

  def files
    @files ||= Dir[File.join(ASSETS, 'html', '*.html')]
  end

  def bench_hpricot
    assert_performance_constant do
      files.each { |file| Hpricot(File.read(file)) }
    end
  end

  def bench_nokogiri
    assert_performance_constant do
      files.each { |file| Nokogiri::HTML(File.read(file)) }
    end
  end

  def bench_ox
    skip 'fails with Ox::ParseError'
    assert_performance_constant do
      files.each { |file| Ox.parse(File.read(file)) }
    end
  end

  def bench_libxml
    skip 'fails with LibXML::XML::Error'
    assert_performance_constant do
      files.each { |file| LibXML::XML::HTMLParser.string(File.read(file)).parse }
    end
  end

  def bench_rexml
    skip 'fails with REXML::ParseException'
    assert_performance_constant do
      files.each { |file| REXML::Document.new(File.open(file)) }
    end
  end
end
