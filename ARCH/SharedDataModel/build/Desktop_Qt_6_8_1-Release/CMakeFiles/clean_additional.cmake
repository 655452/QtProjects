# Additional clean files
cmake_minimum_required(VERSION 3.16)

if("${CONFIG}" STREQUAL "" OR "${CONFIG}" STREQUAL "Release")
  file(REMOVE_RECURSE
  "CMakeFiles/SharedDataModel_autogen.dir/AutogenUsed.txt"
  "CMakeFiles/SharedDataModel_autogen.dir/ParseCache.txt"
  "SharedDataModel_autogen"
  )
endif()
