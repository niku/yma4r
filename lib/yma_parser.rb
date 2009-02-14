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
    responses = [:surface, :reading, :pos, :baseform, :feature]
    @xml.elements['//word_list'].map do |word|
      hash = {}
      responses.each do |name|
        hash[name] = word.elements[name.to_s] ? word.elements[name.to_s].text : nil 
      end
      hash.delete_if{|key,val| val==nil}
    end
  end
end
