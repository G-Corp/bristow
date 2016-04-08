-module(bristow_transform_tests).
-compile([{parse_transform, bristow_transform}]).
-export([foo/1, bar/2, baz/3]).

-include_lib("eunit/include/eunit.hrl").

foo(A) ->
  A.
-alias foo_alias.

bar(A, B) ->
  {A, B}.
-alias bar_alias.
-alias bar_alias_two.

baz(A, B, C) ->
  {A, B, C}.
-alias baz_alias.

bristow_transform_test_() ->
  {setup,
   fun() -> ok end,
   fun(_) -> ok end,
   [
    fun() ->
        ?assertEqual(foo(a), foo_alias(a)),
        ?assertEqual(bar(a, b), bar_alias(a, b)),
        ?assertEqual(bar(a, b), bar_alias_two(a, b)),
        ?assertEqual(baz(a, b, c), baz_alias(a, b, c))
    end,
    fun() ->
        ?assertEqual(foo(a), ?MODULE:foo_alias(a)),
        ?assertEqual(bar(a, b), ?MODULE:bar_alias(a, b)),
        ?assertEqual(bar(a, b), ?MODULE:bar_alias_two(a, b)),
        ?assertEqual(baz(a, b, c), ?MODULE:baz_alias(a, b, c))
    end,
    fun() ->
        ?assertEqual(?MODULE:foo(a), ?MODULE:foo_alias(a)),
        ?assertEqual(?MODULE:bar(a, b), ?MODULE:bar_alias(a, b)),
        ?assertEqual(?MODULE:bar(a, b), ?MODULE:bar_alias_two(a, b)),
        ?assertEqual(?MODULE:baz(a, b, c), ?MODULE:baz_alias(a, b, c))
    end
   ]}.

