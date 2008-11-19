class YmaParser
  require 'rexml/document'
  attr_reader :xml, :total_count, :filtered_count, :word_list
  def initialize(xml)
    @xml = REXML::Document.new(xml)
    @total_count = @xml.elements['//total_count'].text.to_i
    @filtered_count = @xml.elements['//filtered_count'].text.to_i
    @word_list = @xml.elements['//word_list'].map do |word|
      { :surface=>word.elements['surface'].text,
        :reading=>word.elements['reading'].text,
        :pos=>word.elements['pos'].text
      }
    end
  end
end
