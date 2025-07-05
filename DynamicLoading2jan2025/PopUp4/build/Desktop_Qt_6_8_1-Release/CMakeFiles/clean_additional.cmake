# Additional clean files
cmake_minimum_required(VERSION 3.16)

if("${CONFIG}" STREQUAL "" OR "${CONFIG}" STREQUAL "Release")
  file(REMOVE_RECURSE
  "CMakeFiles/PopUp4_autogen.dir/AutogenUsed.txt"
  "CMakeFiles/PopUp4_autogen.dir/ParseCache.txt"
  "PopUp4_autogen"
  )
endif()
