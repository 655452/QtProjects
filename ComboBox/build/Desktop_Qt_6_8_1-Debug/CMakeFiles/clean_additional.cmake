# Additional clean files
cmake_minimum_required(VERSION 3.16)

if("${CONFIG}" STREQUAL "" OR "${CONFIG}" STREQUAL "Debug")
  file(REMOVE_RECURSE
  "CMakeFiles/appComboBox_autogen.dir/AutogenUsed.txt"
  "CMakeFiles/appComboBox_autogen.dir/ParseCache.txt"
  "appComboBox_autogen"
  )
endif()
