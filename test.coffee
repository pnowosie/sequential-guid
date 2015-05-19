#!/usr/bin/env node
# Simplest test framework that actualy works (at least in this case)

Sid = require './sequid'

color =
  red   : '\u001b[31m'
  blue  : '\u001b[34m'
  green : '\u001b[32m'
  reset : '\u001b[0m'

run = (guid) ->
  Sid::deferInit = true
  tmp = new Sid
  tmp.seed = guid
  tmp.next()

assert = (expected, value, desc) ->
  unless expected == value
    console.log (desc or ' -') + ' ................ [' + color.red + 'FAIL' +color.reset + ']'
    console.error "Wrong value, expected [1] but was [2]"
    console.error " [1]:\t#{expected}"
    console.error " [2]:\t#{value}"
  else
    console.log (desc or ' -') + ' ................ [' + color.green + 'OK' +color.reset + ']'

# [TODO] Make sure all above are valid RFC4122 version 4 UUIDs

assert '00000000-0000-4000-a000-000000000001', run '00000000-0000-4000-a000-000000000000' 
assert '00000000-0000-4000-a000-000000000002', run '00000000-0000-4000-a000-000000000001' 
assert '00000000-0000-4000-a000-00000000000a', run '00000000-0000-4000-a000-000000000009' 
assert '00000000-0000-4000-a000-000000000010', run '00000000-0000-4000-a000-00000000000f' 

assert '00000000-0000-4000-a001-000000000000', run '00000000-0000-4000-a000-ffffffffffff'
assert '00000000-0000-4000-b000-000000000000', run '00000000-0000-4000-afff-ffffffffffff' 

assert '00000000-0000-4001-0000-000000000000', run '00000000-0000-4000-ffff-ffffffffffff'
assert '00000000-0000-5000-0000-000000000000', run '00000000-0000-4fff-ffff-ffffffffffff'

assert '00000000-0001-0000-0000-000000000000', run '00000000-0000-ffff-ffff-ffffffffffff'
assert '00000001-0000-0000-0000-000000000000', run '00000000-ffff-ffff-ffff-ffffffffffff'
assert 'f0000000-0000-0000-0000-000000000000', run 'efffffff-ffff-ffff-ffff-ffffffffffff'
assert 'ff000000-0000-0000-0000-000000000000', run 'feffffff-ffff-ffff-ffff-ffffffffffff'
assert '00000000-0000-0000-0000-000000000000', run 'ffffffff-ffff-ffff-ffff-ffffffffffff'

# Test defered initialization
Sid::deferInit = true
assert undefined, (new Sid).seed, 'Defered initialization'

Sid::deferInit = false
guid = (new Sid).seed	# without calling next()
assert 'string', typeof guid, 'Type of initialized guid should be string'
assert 36, guid.length, 'Initialized guid should have correct length' 

# Test sequence of invocation
sid = new Sid
sid.seed = '00000000-0000-4000-a000-000000000000'
sid.next() for i in [1..5]
assert '00000000-0000-4000-a000-000000000005', sid.seed, '1st 5 batch generation'
sid.next() for i in [1..5]
assert '00000000-0000-4000-a000-00000000000a', sid.seed, '2nd 5 batch generation'
