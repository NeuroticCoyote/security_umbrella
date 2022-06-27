%%%-------------------------------------------------------------------
%% @doc security top level supervisor.
%% @end
%%%-------------------------------------------------------------------

-module(security_sup).

-behaviour(supervisor).

-export([start_link/0]).

-export([init/1]).

-define(SERVER, ?MODULE).

start_link() ->
    supervisor:start_link({local, ?SERVER}, ?MODULE, []).

init([]) ->
    SupFlags = #{strategy => one_for_all,
                 intensity => 0,
                 period => 1},
    ChildSpecs = [
            #{
                    id => code_lock,
                    start => {code_lock, start_link, [["1", "2", "3", "4"]]}
            },
            #{
                    id => broadcast,
                    start => {broadcast, start_link, [display]}
            }
    ],
    {ok, {SupFlags, ChildSpecs}}.