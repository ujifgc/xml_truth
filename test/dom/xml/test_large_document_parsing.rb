require 'helper'

class XMLParse < MiniTest::Unit::TestCase
  def self.bench_range
    [1,3]
  end

  def setup
    @filename ||= File.join(ASSETS, 'itunes.xml')
    data
  end

  def data
    @@data ||= begin
      File.read(@filename)
    end
  end
end

class C6StringXML < XMLParse
  def bench_a_split
    assert_performance_linear 0.9 do |n|
      n.times {
        data.split(/\n/)
      }
    end
  end

  def bench_nokogiri
    assert_performance_linear 0.9 do |n|
      n.times {
        Nokogiri::XML(data)
      }
    end
  end

  def bench_libxml
    assert_performance_linear 0.9 do |n|
      n.times {
        LibXML::XML::Parser.string(data).parse
      }
    end
  end

  def bench_hpricot
    assert_performance_linear 0.9 do |n|
      n.times {
        Hpricot.XML(data)
      }
    end
  end

  def bench_rexml
    skip 'Rexml parsing speed is inadequate' unless @go_slow
    assert_performance_linear 0.9 do |n|
      skip if n > 100
      n.times {
        REXML::Document.new(data)
      }
    end
  end

  def bench_ox
    assert_performance_linear 0.9 do |n|
      n.times {
        Ox.parse(data)
      }
    end
  end
end

class C7IOXML < XMLParse
  def bench_a_line
    assert_performance_linear 0.9 do |n|
      n.times {
        File.open(@filename) { |xml| xml.each_line { |line| } }
      }
    end
  end

  def bench_nokogiri
    assert_performance_linear 0.9 do |n|
      n.times {
        File.open(@filename) { |xml| Nokogiri::XML(xml) }
      }
    end
  end

  def bench_libxml
    assert_performance_linear 0.9 do |n|
      n.times {
        File.open(@filename) { |xml| LibXML::XML::Parser.io(xml).parse }
      }
    end
  end

  def bench_hpricot
    assert_performance_linear 0.9 do |n|
      n.times {
        File.open(@filename) { |xml| Hpricot.XML(xml) }
      }
    end
  end

  def bench_ox
    assert_performance_linear 0.9 do |n|
      n.times {
        Ox.load_file(@filename)
      }
    end
  end

  def bench_rexml
    skip 'Rexml IO speed is inadequate' unless @go_slow
    assert_performance_linear 0.9 do |n|
      skip if n > 100
      n.times {
        File.open(@filename) { |xml| REXML::Document.new(xml) }
      }
    end
  end
end

class C8StringSmallXML < C6StringXML
  def self.bench_range
    bench_exp 1, 1000
  end

  def data
    File.read(@filename)
  end

  def setup
    @filename = File.join(ASSETS, 'timeline.xml')
    @go_slow = true
    super
  end
end

class C9IOSmallXML < C7IOXML
  def self.bench_range
    bench_exp 1, 1000
  end

  def setup
    @filename = File.join(ASSETS, 'timeline.xml')
    @go_slow = true
    super
  end
end
