# Additional clean files
cmake_minimum_required(VERSION 3.16)

if("${CONFIG}" STREQUAL "" OR "${CONFIG}" STREQUAL "Release")
  file(REMOVE_RECURSE
  "CMakeFiles/MulticastReceiver_autogen.dir/AutogenUsed.txt"
  "CMakeFiles/MulticastReceiver_autogen.dir/ParseCache.txt"
  "MulticastReceiver_autogen"
  )
endif()
