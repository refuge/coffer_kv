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

%% This is the main API for coffer_kv (cfjkv).

%% First is to assume thw following concepts:
%%
%%   * cfkv has a unique configuration in which you define the backend and its configuration
%%   * cfkv stores key/value pairs in this defined backend
%%   * cfkv serializes all writes
%%   * probably needs some kind of reference for the client to hold to do anything
%%
