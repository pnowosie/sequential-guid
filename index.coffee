uuid = require 'node-uuid'

class SeqUuid
  constructor: ->
    @guid_ver = @guid_ver or 'v4'
    @seed = undefined
    @seed = @generate() unless @deferInit
  
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
    
module.exports = SeqUuid