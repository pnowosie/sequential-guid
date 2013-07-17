# [WARN] !This code does not work properly for all test cases! 
# [TODO] Add header
# [TODO] Sample usage info, how to obtain js version
# [TODO] Generated guid may be invalid as RFC4122 UUID, make generation alg doesn't break version.4 guids

uuid = require 'node-uuid'

class SeqUuid
  constructor: ->
    @guid_ver = @guid_ver or 'v4'
    @seed = undefined
    @seed = @generate() unless @deferInit
  
  # [WARN] Broken, will be changed soon
  # V1: Simpler. more robust incrementation that works
  # V2: Incrementation that won't break version.4 guids  
  next: ->
    _increaseHex = (hex) ->
      startlen = hex.length
      counter = parseInt '0x' + hex
      hex = ''
      if Math.pow(16, startlen) - 1 > counter then hex = (++counter).toString 16
      hex = '0' + hex while hex.length < startlen
      hex
    
    @seed = @generate() unless @seed?
    throw new Error "Seed has invalid format" if @seed.length != 36
    
    lastpart = @seed[36-12..]
    lastpart = _increaseHex lastpart
    if (parseInt '0x' + lastpart) == 0
      @seed = @seed[0..18] + (_increaseHex @seed[18+1...24-1]) + '-'
    
    @seed = @seed[0...24] + lastpart
    
  generate: ->
    uuid[@guid_ver]().toLowerCase()
  
  deferInit: false
  

if require.main == module
  throw new Error "This module is not intended to be run as standalone application."

module.exports = SeqUuid