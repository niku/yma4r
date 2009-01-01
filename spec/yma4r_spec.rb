# -*- coding: utf-8 -*-
require File.join(File.dirname(__FILE__), 'spec_helper')
require 'yma4r'

describe Yma4r, "を new する場合:" do
  it ":appid を String で渡すと new できること" do
    lambda{ Yma4r.new(:appid => 'appid') }.should_not raise_error
  end

  it "引数なしでは ClassX::AttrRequiredError になること" do
    lambda { Yma4r.new }.should raise_error(ClassX::AttrRequiredError)
  end

  it ":appid を String で渡さないと ClassX::InvalidAttrArgument になること" do
    lambda{ Yma4r.new(:appid => 1111) }.should raise_error(ClassX::InvalidAttrArgument)
  end
end

describe Yma4r, "の sentence を設定する場合:" do
  before do
    @yma4r = Yma4r.new(:appid => 'appid')
  end

  it "String で 渡すと sentence に設定されること" do
    @yma4r.sentence = target = 'すもももももももものうち'
    @yma4r.sentence.should == target
  end

  it "String で 渡さないと ClassX::InvalidAttrArgument になること" do
    lambda{ @yma4r.sentence = 1111 }.should raise_error(ClassX::InvalidAttrArgument)
  end
end

describe Yma4r, "の results を設定する場合:" do
  before do
    @yma4r = Yma4r.new(:appid => 'appid')
  end

  it ":ma で 渡すと results に設定されること" do
    @yma4r.results = target = :ma
    @yma4r.results.should == target
  end

  it ":uniq で渡すと results に設定されること" do
    @yma4r.results = target = :uniq
    @yma4r.results.should == target
  end

  it "String で渡すと Symbol になること" do
    @yma4r.results = target = 'ma'
    @yma4r.results.should == target.to_sym
  end

  it ":ma, :uniq 以外なら ClassX::InvalidAttrArgument になること" do
    lambda{ @yma4r.results = :hoge }.should raise_error(ClassX::InvalidAttrArgument)
  end
end

describe Yma4r, "の response を設定する場合:" do
  before do
    @yma4r = Yma4r.new(:appid => 'appid')
  end

  it "[:surface,:reading,:pos] で渡すと response に設定されること" do
    @yma4r.response = target = [:surface,:reading,:pos]
    @yma4r.response.should == target
  end

  it "Symbol で渡すと Array になること" do
    @yma4r.response = target = :surface
    @yma4r.response.should == [target]
  end

  it "Array の内訳が :surface, :reading, :pos, :baseform, :feature なら例外にならないこと" do
    lambda{ @yma4r.response = [:surface] }.should_not raise_error
    lambda{ @yma4r.response = [:reading] }.should_not raise_error
    lambda{ @yma4r.response = [:pos] }.should_not raise_error
    lambda{ @yma4r.response = [:baseform] }.should_not raise_error
    lambda{ @yma4r.response = [:feature] }.should_not raise_error
  end

  it "Array の内訳が :surface, :reading, :pos, :baseform, :feature 以外なら ClassX::InvalidAttrArgument になること" do
    lambda{ @yma4r.response = [:hoge] }.should raise_error(ClassX::InvalidAttrArgument)
  end
end

describe Yma4r, "の filter を設定する場合:" do
  before do
    @yma4r = Yma4r.new(:appid => 'appid')
  end

  it "[1,2,3] で渡すと filter に設定されること" do
    @yma4r.filter = target = [1,2,3]
    @yma4r.filter.should == target
  end

  it "Fixnum で渡すと Array になること" do
    @yma4r.filter = target = 13
    @yma4r.filter.should == [target]
  end

  it "'2|3|4' の文字列で渡すと Array になること" do
    @yma4r.filter = target = '2|3|4'
    @yma4r.filter.should == target.split('|').map { |v| v.to_i }
  end

  it "Array の内訳が 1 以上 13 以下 でないと ClassX::InvalidAttrArgument になること" do
    lambda{ @yma4r.filter = [0] }.should raise_error(ClassX::InvalidAttrArgument)
    lambda{ @yma4r.filter = [14] }.should raise_error(ClassX::InvalidAttrArgument)
  end
end

describe Yma4r, "の ma_response を設定する場合:" do
  before do
    @yma4r = Yma4r.new(:appid => 'appid')
  end

  it "[:surface,:reading,:pos] で渡すと ma_response に設定されること" do
    @yma4r.ma_response = target = [:surface,:reading,:pos]
    @yma4r.ma_response.should == target
  end

  it "Symbol で渡すと Array になること" do
    @yma4r.ma_response = target = :surface
    @yma4r.ma_response.should == [target]
  end

  it "Array の内訳が :surface, :reading, :pos, :baseform, :feature なら例外にならないこと" do
    lambda{ @yma4r.ma_response = [:surface] }.should_not raise_error
    lambda{ @yma4r.ma_response = [:reading] }.should_not raise_error
    lambda{ @yma4r.ma_response = [:pos] }.should_not raise_error
    lambda{ @yma4r.ma_response = [:baseform] }.should_not raise_error
    lambda{ @yma4r.ma_response = [:feature] }.should_not raise_error
  end

  it "Array の内訳が :surface, :reading, :pos, :baseform, :feature 以外なら ClassX::InvalidAttrArgument になること" do
    lambda{ @yma4r.ma_response = [:hoge] }.should raise_error(ClassX::InvalidAttrArgument)
  end
end

describe Yma4r, "の ma_filter を設定する場合:" do
  before do
    @yma4r = Yma4r.new(:appid => 'appid')
  end

  it "[1,2,3] で渡すと ma_filter に設定されること" do
    @yma4r.ma_filter = target = [1,2,3]
    @yma4r.ma_filter.should == target
  end

  it "Fixnum で渡すと Array になること" do
    @yma4r.ma_filter = target = 13
    @yma4r.ma_filter.should == [target]
  end

  it "'2|3|4' の文字列で渡すと Array になること" do
    @yma4r.ma_filter = target = '2|3|4'
    @yma4r.ma_filter.should == target.split('|').map { |v| v.to_i }
  end

  it "Array の内訳が 1 以上 13 以下 でないと ClassX::InvalidAttrArgument になること" do
    lambda{ @yma4r.ma_filter = [0] }.should raise_error(ClassX::InvalidAttrArgument)
    lambda{ @yma4r.ma_filter = [14] }.should raise_error(ClassX::InvalidAttrArgument)
  end
end

 describe Yma4r, "の uniq_response を設定する場合:" do
  before do
    @yma4r = Yma4r.new(:appid => 'appid')
  end

  it "[:surface,:reading,:pos] で渡すと uniq_response に設定されること" do
    @yma4r.uniq_response = target = [:surface,:reading,:pos]
    @yma4r.uniq_response.should == target
  end

  it "Symbol で渡すと Array になること" do
    @yma4r.uniq_response = target = :surface
    @yma4r.uniq_response.should == [target]
  end

  it "Array の内訳が :surface, :reading, :pos, :baseform, :feature なら例外にならないこと" do
    lambda{ @yma4r.uniq_response = [:surface] }.should_not raise_error
    lambda{ @yma4r.uniq_response = [:reading] }.should_not raise_error
    lambda{ @yma4r.uniq_response = [:pos] }.should_not raise_error
    lambda{ @yma4r.uniq_response = [:baseform] }.should_not raise_error
    lambda{ @yma4r.uniq_response = [:feature] }.should_not raise_error
  end

  it "Array の内訳が :surface, :reading, :pos, :baseform, :feature 以外なら ClassX::InvalidAttrArgument になること" do
    lambda{ @yma4r.uniq_response = [:hoge] }.should raise_error(ClassX::InvalidAttrArgument)
  end
end

describe Yma4r, "の uniq_filter を設定する場合:" do
  before do
    @yma4r = Yma4r.new(:appid => 'appid')
  end

  it "[1,2,3] で渡すと uniq_filter に設定されること" do
    @yma4r.uniq_filter = target = [1,2,3]
    @yma4r.uniq_filter.should == target
  end

  it "Fixnum で渡すと Array になること" do
    @yma4r.uniq_filter = target = 13
    @yma4r.uniq_filter.should == [target]
  end

  it "'2|3|4' の文字列で渡すと Array になること" do
    @yma4r.uniq_filter = target = '2|3|4'
    @yma4r.uniq_filter.should == target.split('|').map{ |v| v.to_i }
  end

  it "Array の内訳が 1 以上 13 以下 でないと ClassX::InvalidAttrArgument になること" do
    lambda{ @yma4r.uniq_filter = [0] }.should raise_error(ClassX::InvalidAttrArgument)
    lambda{ @yma4r.uniq_filter = [14] }.should raise_error(ClassX::InvalidAttrArgument)
  end
end

describe Yma4r, "の uniq_by_baseform を設定する場合:" do
  before do
    @yma4r = Yma4r.new(:appid => 'appid')
  end

  it "false を渡すと uniq_by_baseform に設定されること" do
    pending 'falseを登録したいが、nilが帰ってくるなぁ…'
    @yma4r.uniq_by_baseform = target = false
    @yma4r.uniq_by_baseform.should == target.to_s
  end

  it "TrueClass か FalseClass を設定できること" do
    lambda{ @yma4r.uniq_by_baseform = true }.should_not raise_error
    lambda{ @yma4r.uniq_by_baseform = false }.should_not raise_error
  end

  it "TrueClass か FalseClass でないとき ClassX::InvalidAttrArgument になること" do
    lambda{ @yma4r.uniq_by_baseform = 'hoge' }.should raise_error(ClassX::InvalidAttrArgument)
  end
end

describe Yma4r, "の query_string を実行したとき" do
  before do
    @yma4r = Yma4r.new(:appid => 'appid')
  end

  it "sentence が設定されていない場合 ClassX::AttrRequiredError になること" do
    lambda{ @yma4r.query_string }.should raise_error(ClassX::AttrRequiredError)
  end

  it "sentence に設定された内容がURI.encodeされて出力されること" do
    @yma4r.sentence = target = 'すもももももももものうち'
    alist = @yma4r.query_string.split('&').map{ |val| val.split('=') }
    Hash[*alist.flatten]['sentence'].should == URI.encode(target)
  end

  it "results に設定された内容が出力されること" do
    @yma4r.results = target = :ma
    @yma4r.sentence = 'ほげふが'
    alist = @yma4r.query_string.split('&').map{ |val| val.split('=') }
    Hash[*alist.flatten]['results'].should == URI.encode(target.to_s)
  end

  it "response に設定された内容が出力されること" do
    @yma4r.response = target = [:reading, :pos]
    @yma4r.sentence = 'ほげふが'
    alist = @yma4r.query_string.split('&').map{ |val| val.split('=') }
    Hash[*alist.flatten]['response'].should == URI.encode(target.join(','))
  end

  it "filter に設定された内容が出力されること" do
    @yma4r.filter = target = [1,2,3]
    @yma4r.sentence = 'ほげふが'
    alist = @yma4r.query_string.split('&').map{ |val| val.split('=') }
    Hash[*alist.flatten]['filter'].should == URI.encode(target.join('|'))
  end

  it "ma_response に設定された内容が出力されること" do
    @yma4r.ma_response = target = [:reading, :pos]
    @yma4r.sentence = 'ほげふが'
    alist = @yma4r.query_string.split('&').map{ |val| val.split('=') }
    Hash[*alist.flatten]['ma_response'].should == URI.encode(target.join(','))
  end

  it "ma_filter に設定された内容が出力されること" do
    @yma4r.ma_filter = target = [1,2,3]
    @yma4r.sentence = 'ほげふが'
    alist = @yma4r.query_string.split('&').map{ |val| val.split('=') }
    Hash[*alist.flatten]['ma_filter'].should == URI.encode(target.join('|'))
  end

    it "uniq_response に設定された内容が出力されること" do
    @yma4r.uniq_response = target = [:reading, :pos]
    @yma4r.sentence = 'ほげふが'
    alist = @yma4r.query_string.split('&').map{ |val| val.split('=') }
    Hash[*alist.flatten]['uniq_response'].should == URI.encode(target.join(','))
  end

  it "uniq_filter に設定された内容が出力されること" do
    @yma4r.uniq_filter = target = [1,2,3]
    @yma4r.sentence = 'ほげふが'
    alist = @yma4r.query_string.split('&').map{ |val| val.split('=') }
    Hash[*alist.flatten]['uniq_filter'].should == URI.encode(target.join('|'))
  end

  it "uniq_by_baseform に設定された内容が出力されること" do
    @yma4r.uniq_by_baseform = target = true
    @yma4r.sentence = 'ほげふが'
    alist = @yma4r.query_string.split('&').map{ |val| val.split('=') }
    Hash[*alist.flatten]['uniq_by_baseform'].should == URI.encode(target.to_s)
  end

  it "全部設定しても大丈夫なこと" do
    @yma4r.sentence = sentence = 'すもももももももものうち'
    @yma4r.results = results = :ma
    @yma4r.response = response = [:reading, :pos]
    @yma4r.filter = filter = [1,2,3]
    @yma4r.ma_response = ma_response = :surface
    @yma4r.ma_filter = ma_filter = 1
    @yma4r.uniq_response = uniq_response = :feature
    @yma4r.uniq_filter = uniq_filter = '5|6|7'
    @yma4r.uniq_by_baseform = uniq_by_baseform = true

    alist = @yma4r.query_string.split('&').map{ |val| val.split('=') }
    query_hash = Hash[*alist.flatten]

    query_hash['sentence'].should == URI.encode(sentence)
    query_hash['results'].should == URI.encode(results.to_s)
    query_hash['response'].should == URI.encode(response.join(','))
    query_hash['filter'].should == URI.encode(filter.join('|'))
    query_hash['ma_response'].should == URI.encode(ma_response.to_s)
    query_hash['ma_filter'].should == URI.encode(ma_filter.to_s)
    query_hash['uniq_response'].should == URI.encode(uniq_response.to_s)
    query_hash['uniq_filter'].should == URI.encode(uniq_filter)
    query_hash['uniq_by_baseform'].should == URI.encode(uniq_by_baseform.to_s)
  end
end
