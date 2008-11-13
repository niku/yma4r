class YmaParser
  require 'rexml/document'

  attr_reader :xml
  
  class YmaResult
    def initialize(set)
      @set = set
    end

    def surface
      @set.elements['surface'].text
    end
    
    def reading
      @set.elements['reading'].text
    end

    def pos
      @set.elements['pos'].text
    end
  end
  
  def initialize(xml)
    @xml = REXML::Document.new(xml)
  end

  def total_count
    @xml.elements['//total_count'].text.to_i
  end

  def filtered_count
    @xml.elements['//filtered_count'].text.to_i
  end

  def word_list
    @xml.elements['//word_list'].map { |set| YmaResult.new(set) }
  end
end
