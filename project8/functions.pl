count(OpAtom, Ref, Count) :-
    resolve_op(OpAtom, Op),
    findall(Z, (pay(_, _, Z), call(Op, Z, Ref)), List),
    length(List, Count).

max(OpAtom, Ref, Max) :-
    resolve_op(OpAtom, Op),
    findall(Z, (pay(_, _, Z), call(Op, Z, Ref)), List),
    max_list(List, Max).

min(OpAtom, Ref, Min) :-
    resolve_op(OpAtom, Op),
    findall(Z, (pay(_, _, Z), call(Op, Z, Ref)), List),
    min_list(List, Min).

total(OpAtom, Ref, Total) :-
    resolve_op(OpAtom, Op),
    findall(Z, (pay(_, _, Z), call(Op, Z, Ref)), List),
    sum_list(List, Total).

list(OpAtom, Ref, List) :-
    resolve_op(OpAtom, Op),
    findall([F, L, P], (
        pay(F, L, P),
        ( Op == (==) -> P =:= Ref
        ; Op == (\=) -> P =\= Ref
        ; call(Op, P, Ref)
        )
), List).

avg(OpAtom, Ref, Avg) :-
    resolve_op(OpAtom, Op),
    findall(P, (pay(_, _, P), call(Op, P, Ref)), List),
    List \= [],
    sum_list(List, Total),
    length(List, Count),
    Avg is Total / Count.

resolve_op('<=', =<).
resolve_op('>=', >=).
resolve_op('<', <).
resolve_op('>', >).
resolve_op('==', =:=).
resolve_op('\\=', =\=).
