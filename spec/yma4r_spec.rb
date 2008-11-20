# -*- coding: utf-8 -*-
require File.join(File.dirname(__FILE__), 'spec_helper')
require 'yma4r'

describe Yma4r, "を new する場合:" do

  it "引数なしでは例外になること" do
    lambda { Yma4r.new }.should raise_error(ClassX::AttrRequiredError)
  end

  it ":appid をハッシュで渡すと new できること" do
    lambda{ Yma4r.new(:appid => 'hoge') }.should_not raise_error(ClassX::AttrRequiredError)
  end
  
end
