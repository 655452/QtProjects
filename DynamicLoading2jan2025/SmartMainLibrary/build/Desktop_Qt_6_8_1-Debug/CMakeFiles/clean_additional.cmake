# Additional clean files
cmake_minimum_required(VERSION 3.16)

if("${CONFIG}" STREQUAL "" OR "${CONFIG}" STREQUAL "Debug")
  file(REMOVE_RECURSE
  "CMakeFiles/SmartMainLibrary_autogen.dir/AutogenUsed.txt"
  "CMakeFiles/SmartMainLibrary_autogen.dir/ParseCache.txt"
  "SmartMainLibrary_autogen"
  )
endif()
