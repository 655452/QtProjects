file(REMOVE_RECURSE
  "ParseTree/ActionMap.js"
  "ParseTree/main.qml"
  "ParseTree/res.qrc"
)

# Per-language clean rules from dependency scanning.
foreach(lang )
  include(CMakeFiles/appParseTree_tooling.dir/cmake_clean_${lang}.cmake OPTIONAL)
endforeach()
