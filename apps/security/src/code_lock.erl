-module(code_lock).
-behaviour(gen_statem).
-define(NAME, code_lock).

-export([start_link/1]).
-export([button/1]).
-export([init/1, callback_mode/0, terminate/3]).
-export([locked/3, open/3]).

-spec start_link([binary()]) -> gen_statem:start_ret().
start_link(Code) ->
	gen_statem:start_link({local, ?NAME}, ?MODULE, Code, []).

-spec button(binary()) -> ok.
button(Button) ->
	io:format("CALLED CODE LOCK BUTTON WITH BUTTON:~p", [Button]),
	gen_statem:cast(?NAME, {button, Button}).

init(Code) ->
	do_lock(),
	Data = #{code => Code, length => length(Code), buttons => []},
	{ok, locked, Data}.

callback_mode() ->
	state_functions.

locked(
	cast,
	{button, Button},
	#{code := Code, length := Length, buttons := Buttons} = Data
) ->
	SanitisedButton =  binary:replace(Button, [<<"{">>,<<"}">>], <<"">>,  [global]),
	NewButtons =
		if
			length(Buttons) < Length ->
				Buttons;
			true ->
				tl(Buttons)
		end ++ [binary_to_list(SanitisedButton)],

	io:format("GOT HERE:~p", [NewButtons]),

	if
		NewButtons =:= Code ->
			do_unlock(),
			{next_state, open, Data#{buttons := []}, [{state_timeout, 10000, lock}]};
		true ->
			{next_state, locked, Data#{buttons := NewButtons}}
	end.

open(state_timeout, lock, Data) ->
	do_lock(),
	{next_state, locked, Data};
open(cast, {button, _}, Data) ->
	{next_state, open, Data}.



do_lock() ->
	io:format("Lock~n", []).
do_unlock() ->
	io:format("Unlock~n", []).

terminate(_Reason, State, _Data) ->
	State =/= locked andalso do_lock(),
	ok.