-module(fast_disk_log_tests).
-include_lib("eunit/include/eunit.hrl").
-include_lib("fast_disk_log/include/fast_disk_log.hrl").

-define(LOGGER_NAME, test_logger).
-define(LOGGER_PATH, <<"./test.log">>).

%% runners
fast_disk_logger_test_() ->
    {setup,
        fun () -> setup() end,
        fun (_) -> cleanup() end,
    [
        fun open_close_subtest/0,
        fun log_sync_subtest/0
    ]}.

%% tests
open_close_subtest() ->
    {error, no_such_log} = fast_disk_log:close(?LOGGER_NAME),
    ok = fast_disk_log:open(?LOGGER_NAME, ?LOGGER_PATH),
    {error, name_already_open} = fast_disk_log:open(?LOGGER_NAME, ?LOGGER_PATH),
    ok = fast_disk_log:close(?LOGGER_NAME),
    ok = fast_disk_log:open(?LOGGER_NAME, ?LOGGER_PATH),
    ok = fast_disk_log:close(?LOGGER_NAME).

log_sync_subtest() ->
    log_delete(),
    {error, no_such_log} = fast_disk_log:log(?LOGGER_NAME, <<"test">>),
    {error, no_such_log} = fast_disk_log:sync(?LOGGER_NAME),
    ok = fast_disk_log:open(?LOGGER_NAME, ?LOGGER_PATH),
    ok = fast_disk_log:log(?LOGGER_NAME, <<"test">>),
    ok = fast_disk_log:sync(?LOGGER_NAME),
    ?assertEqual(["test"], log_read(1)),
    ok = fast_disk_log:close(?LOGGER_NAME).

%% utils
cleanup() ->
    fast_disk_log_app:stop(),
    log_delete().

log_delete() ->
    file:delete(?LOGGER_PATH).

log_read(N) ->
    {ok, File} = file:open(?LOGGER_PATH, [read]),
    read_loop(N, File).

read_loop(0, _File) ->
    [];
read_loop(N, File) ->
    case file:read_line(File) of
        {ok, Line} ->
            [Line | read_loop(N - 1, File)];
        eof ->
            read_loop(N, File)
    end.

setup() ->
    error_logger:tty(false),
    fast_disk_log_app:start().
