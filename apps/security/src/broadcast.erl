%%%-------------------------------------------------------------------
%%% @author joegoodwin
%%% @copyright (C) 2022, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 08. Jun 2022 15:11
%%%-------------------------------------------------------------------
-module(broadcast).
-author("joegoodwin").

-behaviour(gen_server).

-define(GID, {global, ?MODULE}).
-define(GCALL, ?GID).

%% API
-export([start_link/1, send/1, broadcast/1]).

%% gen_server callbacks
-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2,
	code_change/3]).

-define(SERVER, ?MODULE).

-record(broadcast_state, {}).

%%%===================================================================
%%% API
%%%===================================================================


start_link(Adapter) ->
    gen_server:start_link(?GID, ?MODULE, Adapter, []).

-spec send({atom(), binary()}) -> ok.
send(Message) ->
    gen_server:cast(?GCALL, {message, Message}).

broadcast(Message) ->
	'Elixir.Phoenix.PubSub':broadcast(
		'Elixir.SecurityWeb.PubSub', "security", Message
	).

%%%===================================================================
%%% gen_server callbacks
%%%===================================================================

-spec init(module()) -> {ok, module()}.
init(Adapter) ->
	{ok, Adapter}.

handle_call(_Request, _From, State = #broadcast_state{}) ->
	{reply, ok, State}.

handle_cast({message, Message}, Adapter) ->
	Adapter:send(Message);
handle_cast(_Request, State = #broadcast_state{}) ->
	{noreply, State}.

handle_info(_Info, State = #broadcast_state{}) ->
	{noreply, State}.

terminate(_Reason, _State = #broadcast_state{}) ->
	ok.

code_change(_OldVsn, State = #broadcast_state{}, _Extra) ->
	{ok, State}.

%%%===================================================================
%%% Internal functions
%%%===================================================================