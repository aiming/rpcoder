#!/usr/bin/env ruby
# encoding: utf-8

abort 'environment parameter "PL" required' unless ENV['PL']
lang_path = ':LANG'.sub(':LANG',ENV['PL'])
$LOAD_PATH.unshift(File.expand_path(lang_path, File.dirname(__FILE__)))

$LOAD_PATH.unshift(File.expand_path('./lib', File.dirname(__FILE__)))
require 'rpcoder'
require 'fileutils'

#######################################
# API definition
#######################################

RPCoder.output_path = File.expand_path("#{lang_path}/src", File.dirname(__FILE__))
RPCoder.templates_path = lang_path, 'templates'
RPCoder.name_space = 'com.aiming.rpcoder.generated'
RPCoder.api_class_name = 'API'

# Constants ------------------------------------------------------------------------------------------------------------
# コントラクトバージョンのパラメータ名
CONTRACT_VERSION_VARIABLE_NAME = 'contract_version'

# ユーザ登録
CONTRACT_USER_NAME_LENGTH_MAX = 16 # 登録名の最大長 (半角16,全角8文字)

# 生産兵数
CONTRACT_TRAIN_TROOP_COUNT_MAX = 9999 # 最大数
CONTRACT_TRAIN_TROOP_COUNT_MIN = 1    # 最小数

# マップ
CONTRACT_MAP_MAX = 500  # 最大サイズ
CONTRACT_MAP_MIN = -500 # 最小サイズ

# マップブックマーク
CONTRACT_BOOKMARK_MAP_NAME_LENGTH_MAX = 14 # 登録名の最大長


# Type -----------------------------------------------------------------------------------------------------------------
RPCoder.type "Mail" do |t|
  t.add_field :subject, :String
  t.add_field :body,    :String
end

# Functions ------------------------------------------------------------------------------------------------------------
RPCoder.function "getMail" do |f|
  f.path        = "/mails/:id" # => ("/mails/" + id)
  f.method      = "GET"
  f.add_return_type :mail, "Mail"
  f.add_param  :id, "int"
  f.description = 'メールを取得'
end

RPCoder.function "sendMail" do |f|
  f.path        = "/mails" # => ("/mails/" + id)
  f.method      = "POST"
  f.add_param  :subject, "String"
  f.add_param  :body,    "String"
  f.description = 'メールを送信'
end

RPCoder.function "getError" do |f|
  f.path        = "/error/:statusCode"
  f.method      = "GET"
  f.add_param  :statusCode, :int
  f.description = 'Get Error'
end

RPCoder.export()
