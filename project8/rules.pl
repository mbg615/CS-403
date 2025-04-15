% Salaried employee pay
pay(F, L, P) :-
    salaried(F, L, Weekly),
    P is Weekly.

% Hourly employee pay
pay(F, L, P) :-
    hourly(F, L, Hours, Rate),
    Hours =< 40,
    P is Hours*Rate.

pay(F, L, P) :-
    hourly(F, L, Hours, Rate),
    Hours > 40,
    Hours =< 50,
    Overtime is Hours - 40,
    P is Rate * 40 + Overtime * 1.5 * Rate.

pay(F, L, P) :-
    hourly(F, L, Hours, Rate),
    Hours > 50,
    Regular is 40 * Rate,
    Overtime is 10 * 1.5 * Rate,
    Doubletime is (Hours - 50) * 2.0 * Rate,
    P is Regular + Overtime + Doubletime.

% Commission employee pay
pay(F, L, P) :-
    commission(F, L, Min, Sales, Crate),
    Sales*Crate > Min,
    P is Sales*Crate.

pay(F, L, P) :-
    commission(F, L, Min, Sales, Crate),
    Sales*Crate =< Min,
    P is Min.
