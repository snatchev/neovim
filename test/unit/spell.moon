{:cimport, :eq} = require 'test.unit.helpers'
{:lib, :ffi, :cstr, :to_cstr, :internalize} = cimport './src/types.h', './src/spell.h'

describe 'spell', ->
  describe 'spell_check', ->
    spell_check = (wp, ptr, attrp, capcol, docount) ->
      ptr = to_cstr ptr
      -- wp pointer to the current window
      -- ptr character that could be start of a word
      -- attrp is set to the highlight index for a badly spelled word
      -- capcol is used to check for a Capitalised word after the end of a sentence
      -- docount supposedly counts the number of good words, but appears to be unused.
      spell.spell_check wp, ptr, attrp, capcol, docount

--    setup ->
--      window = ffi.new('struct window_S', {})
--      --attrp  = ffi.new('enum hlf_T')
--      attrp  = ffi.new('int *')
--      capcol = ffi.new('int *')
--
--    it 'should return the length of the word in bytes', ->
--      bytes_count = 3
--      bytes_count = spell_check window, "spell", attrp, capcol, false
--      eq 5, bytes_count
