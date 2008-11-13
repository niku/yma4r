# -*- coding: utf-8 -*-
require 'rubygems'
require 'classx'

class Yma4r
  include ClassX
  require 'yma_parser'
  require 'net/http'

  has :appid,
  :desc => 'アプリケーションID。'
  
  has :sentence,
  :desc => '解析対象のテキストです。',
  :writable => true,
  :optional => true
  
  has :results,
  :desc => '解析結果の種類をコンマで区切って指定します。',
  :default => proc { 'ma' },
  :validate => proc { |val| val.is_a? 'ma' || 'uniq' },
  :writable => true,
  :optional => true

  has :response,
  :desc => 'ma_response, uniq_response のデフォルト設定です。word に返される形態素情報をコンマで区切って指定します。無指定の場合は "surface,reading,pos" になります。',
  :default => proc { 'surface,reading,pos' },
  :validate => proc { |val| val.is_a? 'surface' || 'reading' || 'pos' || 'baseform' || 'feature' },
  :optional => true

  has :filter,
  :desc => 'ma_filter, uniq_filter のデフォルト設定です。解析結果として出力する品詞番号を "｜" で区切って指定します。',
  :default => proc { '1|2|3|4|5|6|7|8|9|10|11|12|13' },
  :optional => true
  
  has :ma_response,
  :desc => 'ma_result 内の word に返される形態素情報をコンマで区切って指定します。無指定の場合 response の指定が用いられます。',
  :default => nil,
  :optional => true
  
  has :ma_filter,
  :desc => 'ma_result 内に解析結果として出力する品詞番号を "｜" で区切って指定します。無指定の場合 filter の指定が用いられます。',
  :default => nil,
  :optional => true
  
  has :uniq_response,
  :desc => 'uniq_result 内の word に返される形態素情報をコンマで区切って指定します。無指定の場合 response の指定が用いられます。',
  :default => nil,
  :optional => true
  
  has :uniq_filter,
  :desc => 'uniq_result 内に解析結果として出力する品詞番号を "｜" で区切って指定します。無指定の場合 filter の指定が用いられます。',
  :default => nil,
  :optional => true
  
  has :uniq_by_baseform,
  :desc => 'このパラメータが true ならば、基本形の同一性により、uniq_result の結果を求めます。',
  :default => proc { false },
  :optional => true

  def analyse
    YmaParser.new(request)
  end
  
  def request
    host = 'jlp.yahooapis.jp'
    path = '/MAService/V1/parse'
    Net::HTTP.start(host){ |http| http.post(path, query_string) }.body
  end

  def query_hash
    keys = ['appid', 'sentence', 'results', 'response', 'filter', 'ma_response', 'ma_filter', 'uniq_response', 'uniq_filter', 'uniq_by_baseform']
    vals = [appid, sentence, results , response, filter, ma_response, ma_filter, uniq_response, uniq_filter, uniq_by_baseform]
    alist = keys.zip(vals)
    Hash[*alist.flatten]
  end

  def query_string
    query_hash.map{ |key,val| "#{URI.encode(key)}=#{URI.encode(val)}" if val }.compact.join('&')
  end

  private :request, :query_hash, :query_string
end
