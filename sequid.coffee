###
*    sequential-guid
*
*    Copyright (c) 2013 Pawel Nowosielski
*    MIT License - http://opensource.org/licenses/mit-license.php
*
*    More info and usage, please refer to README.md file
*    Generation guids version 1 and 4 cannot be done without node-uuid library, [thank you Broofa](https://github.com/broofa/node-uuid).
###

# [WARN] !Current implementation can generate string that is not valid RFC4122 UID! 
# [TODO] Generated guid may be invalid as RFC4122 UUID, make generation alg doesn't break version.4 guids

uuid = if typeof(require) is 'function' then require 'node-uuid' else this.uuid


class SeqUuid
  constructor: ->
    @guid_ver = @guid_ver or 'v4'
    @seed = undefined
    @seed = @generate() unless @deferInit
  
  # V2: Incrementation that won't break version.4 guids  
  next: ->
    carry = true
    _increaseDigit = (digit) ->
      if digit == 'f' 
        carry = true
        return '0'
      carry = false
      if digit == '9' then return 'a'
      String.fromCharCode digit.charCodeAt() + 1
    
    _increase = (digit) -> 
      return digit if digit == '-'
      if carry then _increaseDigit digit else digit
    
    @seed = @generate() unless @seed?
    throw new Error "Seed has invalid format" if @seed.length != 36
    @seed = @seed.toLowerCase()
    
    @seed = ((@seed.split '')
           .reverse()
           .map _increase)
           .reverse()
           .join ''
  
  generate: ->
    uuid[@guid_ver]().toLowerCase()
  
  deferInit: false
  

if typeof(require) isnt 'undefined' and require.main == module
  throw new Error "This module is not intended to be run as standalone application."

if typeof(exports) is 'object'
  module.exports = SeqUuid
else if typeof(define) is 'function' and define.amd
  define (-> SeqUuid)
else
  this.SeqUuid = SeqUuid
