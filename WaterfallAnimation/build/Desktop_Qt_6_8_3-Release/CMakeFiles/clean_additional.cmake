# Additional clean files
cmake_minimum_required(VERSION 3.16)

if("${CONFIG}" STREQUAL "" OR "${CONFIG}" STREQUAL "Release")
  file(REMOVE_RECURSE
  "CMakeFiles/appWaterfallAnimation_autogen.dir/AutogenUsed.txt"
  "CMakeFiles/appWaterfallAnimation_autogen.dir/ParseCache.txt"
  "appWaterfallAnimation_autogen"
  )
endif()
