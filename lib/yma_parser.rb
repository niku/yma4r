module YmaParser
  # See http://jlp.yahooapis.jp/MAService/V1/parseResponse.xsd
  class ResultSet
    require 'rexml/document'
    attr_reader :xml

    def initialize(xml)
      @xml = REXML::Document.new(xml)
    end

    def ma_result
      init_result(:ma_result)
    end

    def uniq_result
      init_result(:uniq_result)
    end

    private
    def init_result(type)
      ResultType.new(type, @xml.elements["ResultSet/#{type}"])
    end
  end

  class ResultType
    require 'rexml/document'
    attr_reader :type, :xml

    def initialize(type, xml)
      @type = type
      @xml = xml
    end

    def total_count
      count(:total_count)
    end

    def filtered_count
      count(:filtered_count)
    end

    def word_list
      @xml.elements["word_list"].map do |wordtype|
        word_list = WordType.new(@type, wordtype)
      end
    end

    private
    def count(type)
      @xml.elements["#{type}"].text.to_i
    end
  end

  class WordType
    require 'rexml/document'
    attr_reader :xml

    def initialize(type, xml)
      @xml = xml

      if type==:uniq_result
        self.instance_eval do
          def count
            element(:count)
          end
        end
      end
    end

    def surface
      element(:surface)
    end

    def reading
      element(:reading)
    end

    def pos
      element(:pos)
    end

    def baseform
      element(:baseform)
    end

    def feature
      element(:feature)
    end

    private
    def element(type)
      @xml.elements["#{type}"].text.to_s
    end
  end
end
