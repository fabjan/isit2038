fun renderPage message progress =
  "<!DOCTYPE html>\
  \<html>\
  \<head>\
  \  <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\
  \  <title>&Auml;r det 2038?</title>\
  \  <style>\
  \    :root {\
  \      --light-color: #69F7BE;\
  \      --dark-color: #1c2128;\
  \    }\
  \    body { font-family: sans-serif; }\
  \    p { font-size: 3em; }\
  \    body { background-color: var(--light-color); }\
  \    p { color: var(--dark-color); }\
  \   .progress-bar { background-color: var(--dark-color); }\
  \    @media (prefers-color-scheme: dark) {\
  \      body { background-color: var(--dark-color); }\
  \      p { color: var(--light-color); }\
  \      .progress-bar { background-color: var(--light-color); }\
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
  \  <div style=\"width: 100%; height: 1px;\">\
  \    <div style=\"width: " ^ progress ^ "%; height: 1px;\" class=\"progress-bar\"></div>\
  \  </div>\
  \</body>\
  \</html>"
