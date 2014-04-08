%% coffer_kv is a simple engine offering a simple API to allow adding key/value pairs with several types of 'storages'.
%% Copyright (C) 2014  Nicolas R Dufour <nicolas.dufour@nemoworld.info>
%% 
%% This program is free software: you can redistribute it and/or modify
%% it under the terms of the GNU General Public License as published by
%% the Free Software Foundation, either version 3 of the License, or
%% (at your option) any later version.
%% 
%% This program is distributed in the hope that it will be useful,
%% but WITHOUT ANY WARRANTY; without even the implied warranty of
%% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%% GNU General Public License for more details.
%% 
%% You should have received a copy of the GNU General Public License
%% along with this program.  If not, see <http://www.gnu.org/licenses/>.

-module(cfkv).

%% This is the main API for coffer_kv (cfkv).

%% First is to assume the following concepts:
%%
%%   * cfkv has a unique configuration in which you define the backend and its configuration
%%   * cfkv stores key/value pairs in this defined backend
%%   * cfkv serializes all writes
%%   * probably needs some kind of reference for the client to hold to do anything
%%

-export([start/0]).
-export([open/1, close/1]).
-export([get/2, put/3]).
-export([delete/2]).
-export([fold/3]).

-spec start() -> ok | {error, Error::term()}.
start() ->
    application:start(cfkv).

-spec open(Uri::binary()) -> {ok, Pid::pid()} | {error, Error::term()}.
open(Uri) ->
    cfkv_manager:open_backend(Uri).

-spec close(Pid::pid()) -> ok.
close(_Pid) ->
    ok.

-spec get(Pid::pid(), Key::binary()) -> {ok, Value::binary()} | {error, Error::term()}.
get(_Pid, _Key) ->
    ok.

-spec put(Pid::pid(), Key::binary(), Value::binary()) -> ok | {error, Error::term()}.
put(_Pid, _Key, _Value) ->
    ok.

-spec delete(Pid::pid(), Key::binary()) -> ok | {error, Error::term()}.
delete(_Pid, _Key) ->
    ok.

-spec fold(Pid::pid(), Func::fun(), Acc::term()) -> {ok, Value::term()} | {error, Error::term()}.
fold(_Pid, _Func, _Acc) ->
    ok.

%% ------------------------------------------------------------------
%% Internal Function Definitions
%% ------------------------------------------------------------------

