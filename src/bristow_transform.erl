-module(bristow_transform).

-export([parse_transform/2]).

parse_transform(Forms, _Options) ->
  {Alias, Forms1} = gen_alias(Forms),
  export_alias(Forms1, Alias).

gen_alias(Forms) ->
  gen_alias(Forms, {}, [], []).

gen_alias([], _, Alias, Acc) ->
  {Alias, lists:reverse(Acc)};
gen_alias([{function,_,Name,_,[{clause,_,Args,_,_}|_]} = Fun|Rest], _, Alias, Acc) ->
  gen_alias(Rest, {Name, Args}, Alias, [Fun|Acc]);
gen_alias([{attribute,N,alias,Name}|Rest], {Fun, Args}, Alias, Acc) ->
  gen_alias(Rest, {Fun, Args}, [{Name, length(Args)}|Alias], [{function,N,Name,length(Args),
                                                               [{clause,N,
                                                                 Args,
                                                                 [],
                                                                 [{call,N,{atom,1,Fun},Args}]}]}|Acc]);
gen_alias([{attribute,_,alias,_}|_], {}, _, _) ->
  erlang:throw("-alias must follow a function definition");
gen_alias([Def|Rest], _, Alias, Acc) ->
  gen_alias(Rest, {}, Alias, [Def|Acc]).

export_alias(Forms, Alias) ->
  lists:map(fun
              ({attribute,N,export,Exports}) ->
                {attribute,N,export,Exports ++ Alias};
              (Other) -> 
                Other
            end, Forms).

