%%%-------------------------------------------------------------------
%% @doc security public API
%% @end
%%%-------------------------------------------------------------------

-module(security_app).

-behaviour(application).

-export([start/2, stop/1]).

start(_StartType, _StartArgs) ->
    security_sup:start_link().

stop(_State) ->
    ok.

%% internal functions
