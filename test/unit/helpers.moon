-- helper function to find Longest Common Subsequence
quick_LCS = (t1, t2) ->
   local m = #t1
   local n = #t2

   -- Build matrix on demand
   local C = {}
   local setmetatable = setmetatable
   local mt_tbl = {
      __index = (t, k) ->
         t[k] = 0
         return 0
   }
   local mt_C = {
      __index = (t, k) ->
         local tbl = {}
         setmetatable(tbl, mt_tbl)
         t[k] = tbl
         return tbl
   }
   setmetatable(C, mt_C)
   for i = 1, m+1 do
      local ci1 = C[i+1]
      local ci = C[i]
      for j = 1, n+1 do
         if t1[i-1] == t2[j-1] then
            ci1[j+1] = ci[j] + 1
         else
            ci1[j+1] = math.max(ci1[j], ci[j+1])
   return C

-- Luajit ffi parser doesn't understand preprocessor directives, so
-- this helper function removes common directives before passing it the to ffi.
-- It will return a pointer to the library table, emulating 'requires'
export defined_headers

cimport = (...) ->
  paths = {...}
  ffi = require 'ffi'
  libnvim = ffi.load './build/src/libnvim-test.so'

  for path in *paths
    header_file = io.popen "/usr/bin/env cc -E #{path}"

    if not header_file
      error "cannot find #{path}"

    header = header_file\read '*a'
    header_file.close!
    header = string.gsub header, '#[^\n]*\n', '\n'
    ffi.cdef header

  internalize = (cdata) ->
    ffi.gc cdata, ffi.C.free
    return ffi.string cdata

  cstr = ffi.typeof 'char[?]'

  to_cstr = (string) ->
    cstr (string.len string) + 1, string

  return {
    ffi: ffi
    lib: libnvim
    cstr: cstr
    to_cstr: to_cstr
    internalize: internalize
  }

--cimport './src/types.h'



-- take a pointer to a C-allocated string and return an interned
-- version while also freeing the memory
return {
  cimport: cimport
  eq: (expected, actual) -> assert.are.same expected, actual
}
