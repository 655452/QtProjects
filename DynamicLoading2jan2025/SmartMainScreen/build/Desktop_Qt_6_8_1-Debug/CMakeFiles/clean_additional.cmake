# Additional clean files
cmake_minimum_required(VERSION 3.16)

if("${CONFIG}" STREQUAL "" OR "${CONFIG}" STREQUAL "Debug")
  file(REMOVE_RECURSE
  "CMakeFiles/SmartMainScreen_autogen.dir/AutogenUsed.txt"
  "CMakeFiles/SmartMainScreen_autogen.dir/ParseCache.txt"
  "SmartMainScreen_autogen"
  )
endif()
