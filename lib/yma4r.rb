# -*- coding: utf-8 -*-
require 'rubygems'
require 'classx'

class Yma4r
  include ClassX
  require 'net/http'
  require 'yma_parser'

  API_URL = URI.parse('http://jlp.yahooapis.jp/MAService/V1/parse')

  has :appid,
  :desc => 'アプリケーションID。',
  :kind_of => String,
  :writable => false

  has :sentence,
  :desc => '解析対象のテキストです。',
  :kind_of => String,
  :optional => true

  has :results,
  :desc => '解析結果の種類をコンマで区切って指定します。',
  :kind_of => Array,
  :coerce => {
    String => proc {|val| [val.to_sym] },
    Symbol => proc {|val| [val]}
  },
  :validate_each => proc { |val| (val == :uniq) || (val == :ma) },
  :optional => true

  has :response,
  :desc => 'ma_response, uniq_response のデフォルト設定です。word に返される形態素情報をコンマで区切って指定します。無指定の場合は "surface,reading,pos" になります。',
  :kind_of => Array,
  :coerce => { Symbol => proc {|val| [val]} },
  :validate_each => proc { |item|
    (item == :surface) ||
    (item == :reading) ||
    (item == :pos) ||
    (item == :baseform) ||
    (item == :feature)
  },
  :optional => true

  has :filter,
  :desc => 'ma_filter, uniq_filter のデフォルト設定です。解析結果として出力する品詞番号を "｜" で区切って指定します。',
  :kind_of => Array,
  :coerce => {
    Fixnum => proc {|val| [val]},
    String => proc {|val| val.split('|').uniq.map{|v| v.to_i}}
  },
  :validate => proc {|item| (item.min >= 1) && (item.max <= 13) },
  :optional => true

  has :ma_response,
  :desc => 'ma_result 内の word に返される形態素情報をコンマで区切って指定します。無指定の場合 response の指定が用いられます。',
  :kind_of => Array,
  :coerce => { Symbol => proc {|val| [val]} },
  :validate_each => proc { |item|
    (item == :surface) ||
    (item == :reading) ||
    (item == :pos) ||
    (item == :baseform) ||
    (item == :feature)
  },
  :optional => true

  has :ma_filter,
  :desc => 'ma_result 内に解析結果として出力する品詞番号を "｜" で区切って指定します。無指定の場合 filter の指定が用いられます。',
  :kind_of => Array,
  :coerce => {
    Fixnum => proc {|val| [val]},
    String => proc {|val| val.split('|').uniq.map{|v| v.to_i}}
  },
  :validate => proc {|item| (item.min >= 1) && (item.max <= 13) },
  :optional => true

  has :uniq_response,
  :desc => 'uniq_result 内の word に返される形態素情報をコンマで区切って指定します。無指定の場合 response の指定が用いられます。',
  :kind_of => Array,
  :coerce => { Symbol => proc {|val| [val]} },
  :validate_each => proc { |item|
    (item == :surface) ||
    (item == :reading) ||
    (item == :pos) ||
    (item == :baseform) ||
    (item == :feature)
  },
  :optional => true

  has :uniq_filter,
  :desc => 'uniq_result 内に解析結果として出力する品詞番号を "｜" で区切って指定します。無指定の場合 filter の指定が用いられます。',
  :kind_of => Array,
  :coerce => {
    Fixnum => proc {|val| [val]},
    String => proc {|val| val.split('|').uniq.map{|v| v.to_i}}
  },
  :validate => proc {|item| (item.min >= 1) && (item.max <= 13) },
  :optional => true

  has :uniq_by_baseform,
  :desc => 'このパラメータが true ならば、基本形の同一性により、uniq_result の結果を求めます。',
  :validate => proc{ |val| (val.is_a? TrueClass) || (val.is_a? FalseClass) },
  :optional => true

  def query
    hash.map { |key,val|
      unless (val == nil || val == '')
        "#{URI.encode(key)}=#{URI.encode(val)}"
      end
    }.compact.join('&')
  end

  def parse
    YmaParser::ResultSet.new(post)
  end

  private
  def post
    Net::HTTP.start(API_URL.host){|http| http.post(API_URL.path, query)}.body
  end

  def hash
    if sentence == nil
      raise ClassX::AttrRequiredError
    end

    keys = ['appid', 'sentence', 'results', 'response', 'filter', 'ma_response', 'ma_filter', 'uniq_response', 'uniq_filter', 'uniq_by_baseform']
    vals = [appid,
            sentence,
            (response_for_query results),
            (response_for_query response),
            (filter_for_query filter),
            (response_for_query ma_response),
            (filter_for_query ma_filter),
            (response_for_query uniq_response),
            (filter_for_query uniq_filter),
            (uniq_by_baseform_for_query)]
    alist = keys.zip(vals)
    Hash[*alist.flatten]
  end

  def results_for_query val
    val == nil ? nil : val.join(',')
  end

  def response_for_query val
    val == nil ? nil : val.join(',')
  end

  def filter_for_query val
    val == nil ? nil : val.join('|')
  end

  def uniq_by_baseform_for_query
    uniq_by_baseform == nil ? nil : uniq_by_baseform.to_s
  end
end
