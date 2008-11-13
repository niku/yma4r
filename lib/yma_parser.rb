class YmaParser
  require 'rexml/document'

  class YmaResult
    attr_reader :surface, :reading, :pos
    def initialize(set)
      @surface = set.elements['surface'].text
      @reading = set.elements['reading'].text
      @pos = set.elements['pos'].text      
    end
  end
  
  attr_reader :xml, :total_count, :filtered_count, :word_list
  def initialize(xml)
    @xml = REXML::Document.new(xml)
    @total_count = @xml.elements['//total_count'].text.to_i
    @filtered_count = @xml.elements['//filtered_count'].text.to_i
    @word_list = @xml.elements['//word_list'].map{ |set| YmaResult.new(set) }
  end
end
