# Additional clean files
cmake_minimum_required(VERSION 3.16)

if("${CONFIG}" STREQUAL "" OR "${CONFIG}" STREQUAL "Debug")
  file(REMOVE_RECURSE
  "CMakeFiles/MulticastSender_autogen.dir/AutogenUsed.txt"
  "CMakeFiles/MulticastSender_autogen.dir/ParseCache.txt"
  "MulticastSender_autogen"
  )
endif()
