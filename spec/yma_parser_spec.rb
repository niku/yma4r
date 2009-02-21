# -*- coding: utf-8 -*-
require File.join(File.dirname(__FILE__), 'spec_helper')
require 'yma_parser'
require 'rexml/document'

describe YmaParser, ":について" do
  before do
    @xml = <<-'__EOL__'
<?xml version="1.0" encoding="UTF-8" ?>
<ResultSet xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns="urn: yahoo:jp:jlp" xsi:schemaLocation="urn:yahoo:jp:jlp
http://jlp.yahooapis.jp/MAService/V1/parseResponse.xsd">
  <ma_result>
    <total_count>9</total_count>
    <filtered_count>9</filtered_count>
    <word_list>
      <word>
      <surface>庭</surface>
      <reading>にわ</reading>
      <pos>名詞</pos>
      <baseform>庭</baseform>
      </word>
      <word>
      <surface>に</surface>
      <reading>に</reading>
      <pos>助詞</pos>
      <baseform>に</baseform>
      </word>
      <word>
      <surface>は</surface>
      <reading>は</reading>
      <pos>助詞</pos>
      <baseform>は</baseform>
      </word>
      <word>
      <surface>二</surface>
      <reading>2</reading>
      <pos>名詞</pos>
      <baseform>2</baseform>
      </word>
      <word>
      <surface>羽</surface>
      <reading>わ</reading>
      <pos>名詞</pos>
      <baseform>羽</baseform>
      </word>
      <word>
      <surface>ニワトリ</surface>
      <reading>にわとり</reading>
      <pos>名詞</pos>
      <baseform>ニワトリ</baseform>
      </word>
      <word>
      <surface>が</surface>
      <reading>が</reading>
      <pos>助詞</pos>
      <baseform>が</baseform>
      </word>
      <word>
      <surface>いる</surface>
      <reading>いる</reading>
      <pos>動詞</pos>
      <baseform>いる</baseform>
      </word>
      <word>
      <surface>。</surface>
      <reading>。</reading>
      <pos>特殊</pos>
      <baseform>。</baseform>
      </word>
    </word_list>
  </ma_result>
  <uniq_result>
    <total_count>9</total_count>
    <filtered_count>5</filtered_count>
    <word_list>
      <word>
      <surface>庭</surface>
      <reading>にわ</reading>
      <pos>名詞</pos>
      <baseform>庭</baseform>
      <count>1</count>
      </word>
      <word>
      <surface>二</surface>
      <reading>2</reading>
      <pos>名詞</pos>
      <baseform>2</baseform>
      <count>1</count>
      </word>
      <word>
      <surface>羽</surface>
      <reading>わ</reading>
      <pos>名詞</pos>
      <baseform>羽</baseform>
      <count>1</count>
      </word>
      <word>
      <surface>ニワトリ</surface>
      <reading>にわとり</reading>
      <pos>名詞</pos>
      <baseform>ニワトリ</baseform>
      <count>1</count>
      </word>
      <word>
      <surface>いる</surface>
      <reading>いる</reading>
      <pos>動詞</pos>
      <baseform>いる</baseform>
      <count>1</count>
      </word>
    </word_list>
  </uniq_result>
</ResultSet>
__EOL__
    @result = YmaParser::ResultSet.new(@xml)
  end

  it "xml を実行したとき"

  describe "ma_result を実行したとき" do
    it "xml の返り値は ma_result 以下の xml に関するものであること" do
      # これ微妙…
      @result.ma_result.xml.to_s.should == REXML::Document.new(@xml).elements["//ma_result"].to_s
    end

    it "total_count, filterd_count, word_list を返せること" do
      @result.ma_result.should respond_to :total_count, :filtered_count, :word_list
    end

    it "total_count, filterd_count の帰り値は整数であること" do
      @result.ma_result.total_count.should be_kind_of Integer
      @result.ma_result.filtered_count.should be_kind_of Integer
    end

    it "word_list の要素は surface,reading,pos,baseform,feature メソッドを返すこと" do
      @result.ma_result.word_list.each do |word_type|
        word_type.should respond_to :surface, :reading, :pos, :baseform, :feature
      end
    end

    it "word の要素は xmlに準じていること" do
      @result.ma_result.word_list.first do |word_type|
        word_type.surface.should eql '庭'
        word_type.reading.should eql 'にわ'
        word_type.pos.should eql '名詞'
        word_type.baseform.should eql '庭'
      end
    end
  end

  describe "uniq_result を実行したとき" do
    it "xml の返り値は ma_result 以下の xml に関するものであること" do
      # これ微妙…
      @result.uniq_result.xml.to_s.should == REXML::Document.new(@xml).elements["//uniq_result"].to_s
    end

    it "total_count, filterd_count, word_list を返せること" do
      @result.uniq_result.should respond_to :total_count, :filtered_count, :word_list
    end

    it "total_count, filterd_count の帰り値は整数であること" do
      @result.uniq_result.total_count.should be_kind_of Integer
      @result.uniq_result.filtered_count.should be_kind_of Integer
    end

    it "word_list の要素は surface,reading,pos,baseform,feature,pass メソッドを返すこと" do
      @result.uniq_result.word_list.each do |word_type|
        word_type.should respond_to :surface, :reading, :pos, :baseform, :feature, :count
      end
    end

    it "word の要素は xmlに準じていること" do
      @result.ma_result.word_list.first do |word_type|
        word_type.surface.should eql '庭'
        word_type.reading.should eql 'にわ'
        word_type.pos.should eql '名詞'
        word_type.baseform.should eql '庭'
        word_type.count.should eql 1
      end
    end
  end
end
