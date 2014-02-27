require 'helper'

class XMLPath < MiniTest::Unit::TestCase
  def self.bench_range
    [1,2,4]
  end

  def setup
    data
    hdoc
    ndoc
    ldoc
    odoc
  end

  def data
    @@data ||= begin
      puts 'Parsing...'
      File.read(File.join(ASSETS, 'itunes.xml'))
    end
    @@number_of_integers ||= @@data.scan('<integer>').count
    @@number_of_rated ||= @@data.scan('<key>Rating</key>').count
    @@data
  end

  def hdoc
    @@hdoc ||= Hpricot.XML(data)
  end

  def ldoc
    @@ldoc ||= LibXML::XML::Parser.string(data).parse
  end

  def ndoc
    @@ndoc ||= Nokogiri::XML(data)
  end

  def odoc
    @@odoc ||= Ox.parse(data)
  end

  def rdoc
    @@rdoc ||= REXML::Document.new(data)
  end
end

class C3BasicPath < XMLPath
  def path
    '//integer'
  end

  def opath
    '*/integer'
  end

  def actual_sum
    self.class.bench_range.inject(0){ |all,n| all += n*@@number_of_integers }
  end

  def bench_nokogiri
    sum = 0
    assert_performance_linear do |n|
      n.times do
        sum += ndoc.xpath(path).length
      end
    end
    assert_equal actual_sum, sum
  end

  def bench_libxml
    sum = 0
    assert_performance_linear do |n|
      n.times do
        sum += ldoc.find(path).length
      end
    end
    assert_equal actual_sum, sum
  end

  def bench_ox
    sum = 0
    assert_performance_linear do |n|
      n.times do
        sum += odoc.locate(opath).length
      end
    end
    assert_equal actual_sum, sum
  end

  def bench_hpricot
    sum = 0
    assert_performance_linear do |n|
      n.times do
        sum += hdoc.search(path).length
      end
    end
    assert_equal actual_sum, sum
  end

  def bench_rexml
    skip 'Rexml xpath speed is inadequate'
    sum = 0
    assert_performance_linear do |n|
      n.times do
        sum += REXML::XPath.match(rdoc, path).length
      end
    end
    assert_equal actual_sum, sum
  end
end

class C4MediumPath < C3BasicPath
  def path
    '//key[text() = "Rating"]'
  end

  def bench_ox
    skip 'Ox does not locate by content'
  end

  def actual_sum
    self.class.bench_range.inject(0){ |all,n| all += n*@@number_of_rated }
  end
end
