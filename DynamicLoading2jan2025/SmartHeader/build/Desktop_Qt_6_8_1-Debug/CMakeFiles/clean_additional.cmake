# Additional clean files
cmake_minimum_required(VERSION 3.16)

if("${CONFIG}" STREQUAL "" OR "${CONFIG}" STREQUAL "Debug")
  file(REMOVE_RECURSE
  "CMakeFiles/SmartHeader_autogen.dir/AutogenUsed.txt"
  "CMakeFiles/SmartHeader_autogen.dir/ParseCache.txt"
  "SmartHeader_autogen"
  )
endif()
