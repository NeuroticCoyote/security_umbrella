-module(display).

-export([
    show/1,
    state/1,
    show_timeout/1
]).

-spec show(binary()) -> ok.
show(Message) ->
    io:format("Sending show: ~p", [Message]).

-spec state(atom()) -> ok.
state(State) ->
    io:format("Sending state: ~p", [State]).

-spec show_timeout(atom()) -> ok.
show_timeout(Name) ->
    io:format("Sending timeout: ~p", [Name]).