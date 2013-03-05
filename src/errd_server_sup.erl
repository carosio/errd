%%%-------------------------------------------------------------------
%% @copyright Geoff Cant
%% @author Geoff Cant <nem@erlang.geek.nz>
%% @version {@vsn}, {@date} {@time}
%% @doc errd_server supervisor
%% @end
%%%-------------------------------------------------------------------
-module(errd_server_sup).

-behaviour(supervisor).

%% API
-export([start_link/1]).

%% Supervisor callbacks
-export([init/1]).

-define(SERVER, ?MODULE).

%%====================================================================
%% API functions
%%====================================================================
%%--------------------------------------------------------------------
%% @spec start_link() -> {ok,Pid} | ignore | {error,Error}
%% @doc: Starts the supervisor
%% @end
%%--------------------------------------------------------------------
start_link(ServerName) ->
    supervisor:start_link({local, ?SERVER}, ?MODULE, [ServerName]).

%%====================================================================
%% Supervisor callbacks
%%====================================================================
%%--------------------------------------------------------------------
%% Func: init
%% @spec (Args) -> {ok,  {SupFlags,  [ChildSpec]}} |
%%                 ignore                          |
%%                 {error, Reason}
%% @doc Whenever a supervisor is started using
%% supervisor:start_link/[2,3], this function is called by the new process
%% to find out about restart strategy, maximum restart frequency and child
%% specifications.
%% @end
%%--------------------------------------------------------------------
init([ServerName]) ->
    AChild = {"RRD Server",
              {errd_server,start_link,[ServerName]},
              permanent,2000,worker,
              [errd_server]},
    {ok,{{one_for_one,1,2}, [AChild]}}.

%%====================================================================
%% Internal functions
%%====================================================================

% vim: set ts=4 sw=4 expandtab:
