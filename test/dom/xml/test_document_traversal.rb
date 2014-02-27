require 'helper'

class C2XMLWalk < MiniTest::Unit::TestCase
  def self.bench_range
    bench_exp 1, 1000
  end

  def actual_sum
    self.class.bench_range.inject(0){ |all,n| all += n*@id_sum }
  end

  def setup
    data = File.read(File.join(ASSETS, 'timeline.xml'))
    @id_sum = data.scan(/\<id\>\s*(\d+)\s*\<\/id\>/).flatten.map(&:to_i).inject(0,&:+)
    
    @ndoc = Nokogiri::XML(data)
    @ldoc = LibXML::XML::Parser.string(data).parse
    @hdoc = Hpricot.XML(data)
    @rdoc = REXML::Document.new(data)
    @odoc = Ox.parse(data)
  end

  def bench_nokogiri
    sum = 0
    assert_performance_linear do |n|
      n.times do
        list = @ndoc.root.children.dup.to_a
        while !list.empty?
          node = list.pop
          sum += node.content.to_i if node.name == 'id'
          list += node.children
        end
      end
    end
    assert_equal actual_sum, sum
  end

  def bench_libxml
    sum = 0
    assert_performance_linear do |n|
      n.times do
        list = @ldoc.root.children.dup
        while !list.empty?
          node = list.pop
          sum += node.content.to_i if node.name == 'id'
          list += node.children
        end
      end
    end
    assert_equal actual_sum, sum
  end

  def bench_ox
    sum = 0
    assert_performance_linear do |n|
      n.times do
        list = @odoc.nodes.dup
        while !list.empty?
          node = list.pop
          if node.kind_of?(Ox::Element)
            sum += node.text.to_i if node.value == 'id'
            list += node.nodes
          end
        end
      end
    end
    assert_equal actual_sum, sum
  end

  def bench_hpricot
    sum = 0
    assert_performance_linear do |n|
      n.times do
        list = @hdoc.root.children.dup
        while !list.empty?
          node = list.pop
          next unless node.respond_to?(:children)
          sum += node.inner_html.to_i if node.name == 'id'
          next unless node.children
          list += node.children
        end
      end
    end
    assert_equal actual_sum, sum
  end

  def bench_rexml
    sum = 0
    assert_performance_linear do |n|
      n.times do
        list = @rdoc.root.children.dup
        while !list.empty?
          node = list.pop
          next unless node.respond_to?(:children)
          sum += node.text.to_i if node.name == 'id'
          next unless node.children
          list += node.children
        end
      end
    end
    assert_equal actual_sum, sum
  end
end
