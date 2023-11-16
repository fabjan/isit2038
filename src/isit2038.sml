(*
 * Copyright 2023 Fabian Bergström
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *)

(*
 * Has 03:14:07 UTC on 19 January 2038 passed yet?
 *)

val newYearsDay2038 = Date.date {
  year = 2038, month = Date.Jan, day = 1,
  hour = 0, minute = 0, second = 0,
  offset = SOME Time.zeroTime
}

fun tellTime () =
  let
    val timeNow = Time.now ()
    val lastSecond = Time.fromSeconds 2147483647
    val isIt2038 = (Date.toTime newYearsDay2038) <= timeNow
    val isItReally = lastSecond < timeNow
    val progress = (Time.toReal timeNow) / (Time.toReal lastSecond)
    val progress = LargeReal.floor (progress * 100.0)
    val message = if isIt2038 then (if isItReally then "ja" else "troligtvis") else "nej"
  in
    response 200 "text/html" (renderPage message (Int.toString progress))
  end

fun router req =
  case (#method req, #path req) of
      ("GET", "/") => tellTime ()
    | _ => response 404 "text/plain" "Not found\n"

fun main () =
  let
    val sock = INetSock.TCP.socket ()
    val portOpt = Option.mapPartial Int.fromString (OS.Process.getEnv "PORT")
    val port = case portOpt of
        NONE => 3000
      | SOME x => x
  in
    Socket.Ctl.setREUSEADDR (sock, true);
    Socket.bind (sock, INetSock.any port);
    Socket.listen (sock, 5);
    print ("Listening on port " ^ (Int.toString port) ^ "\n");
    serveHTTP sock router
  end
