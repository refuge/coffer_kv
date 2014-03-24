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

-module(cfkv_uri).

-include("cfkv.hrl").

-export([parse/1]).

%% 
% cfkv:backend:options
parse(Uri) when is_binary(Uri) ->
    case re:split(Uri, ?URI_DELIM) of
        [?URI_HEADER, BackendName, OptionsValue] ->
            case find_backend(BackendName) of
                undefined ->
                    {error, unknown_backend};
                Backend ->
                    case parse_options(OptionsValue) of
                        {error, Error} ->
                            {error, Error, []};
                        {error, Error, Errors} ->
                            {error, Error, Errors};
                        {ok, Options} ->
                            DecodedUri = #uri{
                                value=Uri,
                                backend=Backend,
                                options=Options
                            },
                            {ok, DecodedUri}
                    end
            end;
        _ ->
            {error, wrong_uri}
    end;
parse(_) ->
    {error, wrong_uri}.

%% Internal API

find_backend(BackendName) when is_binary(BackendName) ->
    case application:get_env(cfkv, backends) of
        undefined ->
            undefined;
        {ok, BackendDefinition} ->
            proplists:get_value(BackendName, BackendDefinition)
    end;
find_backend(_) ->
    undefined.

parse_options(<<>>) ->
    {ok, []};
parse_options(OptionsValue) when is_binary(OptionsValue) ->
    KeyValueBins = re:split(OptionsValue, ?URI_OPTS_DELIM),
    Values = lists:foldl(
        fun(X, {O, E}) ->
            case re:split(X, ?URI_OPT_DELIM) of
                [Key, Value] ->
                    {[{Key, Value}|O], E};
                BadValue ->
                    {O, [BadValue|E]}
            end
        end,
        {[],[]},
        KeyValueBins
    ),
    case Values of
        {Options, []} ->
            {ok, Options};
        {_, Errors} ->
            {error, wrong_uri, Errors}
    end;
parse_options(_) ->
    {error, wrong_uri}.
