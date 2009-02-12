class YmaParser
  require 'rexml/document'
  attr_reader :xml
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
    @xml.elements['//word_list'].map do |word|
      {:surface=>word.elements['surface'].text, :reading=>word.elements['reading'].text, :pos=>word.elements['pos'].text}
    end
  end
end
