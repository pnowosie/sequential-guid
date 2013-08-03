# [WARN] !Current implementation can generate string that is not valid RFC4122 UID! 
# [TODO] Add header
# [TODO] Sample usage info, how to obtain js version
# [TODO] Generated guid may be invalid as RFC4122 UUID, make generation alg doesn't break version.4 guids

uuid = require 'node-uuid'

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
    
    @seed
    
  generate: ->
    uuid[@guid_ver]().toLowerCase()
  
  deferInit: false
  

if require.main == module
  throw new Error "This module is not intended to be run as standalone application."

module.exports = SeqUuid