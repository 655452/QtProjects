# Additional clean files
cmake_minimum_required(VERSION 3.16)

if("${CONFIG}" STREQUAL "" OR "${CONFIG}" STREQUAL "Debug")
  file(REMOVE_RECURSE
  "CMakeFiles/appWaterFall_autogen.dir/AutogenUsed.txt"
  "CMakeFiles/appWaterFall_autogen.dir/ParseCache.txt"
  "appWaterFall_autogen"
  )
endif()
