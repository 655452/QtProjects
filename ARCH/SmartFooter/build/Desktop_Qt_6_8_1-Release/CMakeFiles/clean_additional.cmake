# Additional clean files
cmake_minimum_required(VERSION 3.16)

if("${CONFIG}" STREQUAL "" OR "${CONFIG}" STREQUAL "Release")
  file(REMOVE_RECURSE
  "CMakeFiles/SmartFooter_autogen.dir/AutogenUsed.txt"
  "CMakeFiles/SmartFooter_autogen.dir/ParseCache.txt"
  "SmartFooter_autogen"
  )
endif()
