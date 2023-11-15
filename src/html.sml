fun renderPage message progress =
  "<!DOCTYPE html>\
  \<html>\
  \<head>\
  \  <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\
  \  <title>&Auml;r det 2038?</title>\
  \  <style>\
  \    body { font-family: sans-serif; }\
  \    p { font-size: 3em; }\
  \    body { background-color: #69F7BE; }\
  \    p { color: #1c2128; }\
  \    @media (prefers-color-scheme: dark) {\
  \      body { background-color: #1c2128; }\
  \      p { color: #69F7BE; }\
  \    }\
  \    html, body {\
  \      height: 100%;\
  \      margin: 0;\
  \    }\
  \    body {\
  \      display: flex;\
  \      flex-direction: column;\
  \      justify-content: center;\
  \      align-items: center;\
  \    }\
  \  </style>\
  \</head>\
  \<body>\
  \  <p>" ^ message ^ "</p>\
  \  <div style=\"width: 100%; height: 1px; background-color: #1c2128;\">\
  \    <div style=\"width: " ^ progress ^ "%; height: 1px; background-color: #69F7BE;\"></div>\
  \  </div>\
  \</body>\
  \</html>"
