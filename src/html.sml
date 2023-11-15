fun renderPage s =
  "<!DOCTYPE html>\
  \<html>\
  \<head>\
  \<meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\
  \<title>&Auml;r det 2038?</title>\
  \<style>\
  \body { font-family: sans-serif; }\
  \html, body { height: 100%; }\
  \body { display: flex; align-items: center; justify-content: center; }\
  \p { font-size: 3em; }\
  \body { background-color: #69F7BE; }\
  \p { color: #1c2128; }\
  \@media (prefers-color-scheme: dark) {\
  \  body { background-color: #1c2128; }\
  \  p { color: #69F7BE; }\
  \}\
  \</style>\
  \</head>\
  \<body>\
  \<p>" ^ s ^ "</p>\
  \</body>\
  \</html>"
