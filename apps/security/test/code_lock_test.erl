-module(code_lock_test).
-include_lib("eunit/include/eunit.hrl").

happy_path_test() ->
	{ok, Pid} = code_lock:start_link(["1", "2", "3", "4"]),
	{locked, _} = sys:get_state(Pid),

	ok = code_lock:button("1"),
	ok = code_lock:button("2"),
	ok = code_lock:button("3"),
	ok = code_lock:button("4"),

	timer:sleep(200),

	{open, _} = sys:get_state(Pid).