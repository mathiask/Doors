% Solving the "Zauberschloss" puzzle...
% ... and generating random puzzles that have solutions.
%
% 20081021-25 Mathias Kegelmann
%
% NOTE: Needs SWI PROLOG for arbitrary precision arithmetic

move_thru_door(Id, From, To, Open_doors) :- 
        move(Id, From, To, Canonical), 
        member(Canonical, Open_doors).

move(Id, From, To, (From, To)) :- move_undirected(Id, From, To).
move(Id, From, To, (To, From)) :- move_undirected(Id, To, From).

% toggle(door, open_doors, new_open_doors)
% open_doors must not contain duplicates and must be sorted 
% in lexicographical ordering
toggle(D, [D|Rest], Rest) :- !.
toggle(D, [], [D]) :- !.
toggle((F, T), [(F2, T2)|Rest], [(F, T), (F2, T2) | Rest]) :-
        (F < F2; (F == F2, T < T2)), !.
toggle(D, [H|T], [H|T2]) :- toggle(D, T, T2).

toggle_doors([], D, D).
toggle_doors([D|Ds], OD, OD2) :-
        toggle(D, OD, OD1),
        toggle_doors(Ds, OD1, OD2).

step(Id, pos(From, Doors), move(From, To), pos(To, Doors)) :- 
        move_thru_door(Id, From, To, Doors).
step(Id, pos(Room, Open_doors), doorknob(Room), pos(Room, New_doors)) :- 
        doors(Id, Room, Doors),
        toggle_doors(Doors, Open_doors, New_doors).

solve(Id, Solution) :- start(Id, Start), solve(Id, Start, Solution).
solve(Id, Start, Solution) :- solve(Id, Start, [Start], Solution).
solve(Id, pos(Goal, _), _, []) :- goal(Id, Goal).
solve(Id, Position, History, [Move|Solution]) :-
        step(Id, Position, Move, New_position),
        \+ member(New_position, History),
        solve(Id, New_position, [New_position|History], Solution).

% breadth first solver

solve_breadth_first(Id, Solution) :- 
        start(Id, Start), 
        solve_breadth_first(Id, [(Start, [])], [Start], Solution).
solve_breadth_first(Id, [(pos(Goal,_), Path)|_], _, Solution) :- goal(Id, Goal), !, reverse(Path, Solution).
solve_breadth_first(Id, [(Position, Path)|Queue], History, Solution) :-
        findall((New_position, [Move|Path]), step(Id, Position, Move, New_position), Nodes),
        filter_history(Nodes, History, New_nodes),
        extract_positions(New_nodes, New_positions),
        append(Queue, New_nodes, New_queue),
        append(New_positions, History, New_History),
        solve_breadth_first(Id, New_queue, New_History, Solution).

filter_history([], _, []).
filter_history([(Position, _)|T], History, T2) :- member(Position, History), !, filter_history(T, History, T2).
filter_history([Node|T], History, [Node|T2]) :- filter_history(T, History, T2).

extract_positions([], []).
extract_positions([(Position, _)|T], [Position|T2]) :- extract_positions(T, T2). 


% ========== Encoding Of The Actual Puzzle Geometries ==========

% Id 2: the original 2x2 puzzle
move_undirected(2, 1, 2).
move_undirected(2, 1, 3).
move_undirected(2, 3, 4).
move_undirected(2, 2, 4).

% Id 3: the original 3x3
move_undirected(3, 1, 2).
move_undirected(3, 2, 3).
move_undirected(3, 1, 4).
move_undirected(3, 2, 5).
move_undirected(3, 3, 6).
move_undirected(3, 4, 5).
move_undirected(3, 5, 6).
move_undirected(3, 4, 7).
move_undirected(3, 5, 8).
move_undirected(3, 6, 9).
move_undirected(3, 7, 8).
move_undirected(3, 8, 9).

% Id (Open_doors, Doorknobs): the Id encodes the geometry
move_undirected((_,_), F, T) :- move_undirected(3, F, T).


doors(2, 1, [(1, 2), (1, 3)]).
doors(2, 2, [(1, 2)]).
doors(2, 3, [(2, 4)]).

doors(3, 1, [(1,2), (1,4)]).
doors(3, 2, [(5,8)]).
doors(3, 3, [(4,7)]).
doors(3, 4, [(2,3), (7,8)]).
doors(3, 5, [(5,6), (5,8)]).
doors(3, 8, [(6,9)]).

doors((_, [(Room, Doors)|_]),  Room, Doors) :- !.
doors((Open_doors, [_|Doorknobs]), Room, Doors) :- 
        doors((Open_doors, Doorknobs), Room, Doors).


% start(positions, list of open doors)
start(2, pos(1, [(1, 2)])).
start(3, pos(1, [(1,4), (5,8), (7,8)])).
start((Open_doors, _), pos(1, Open_doors)).

goal(2, 4).
goal(3, 9).
goal((_,_), 9).

% Reformulation of "Id 3" in generic form:
generic3(([(1,4), (5,8), (7,8)],
         [(1, [(1,2), (1,4)]),
          (2, [(5,8)]),
          (3, [(4,7)]),
          (4, [(2,3), (7,8)]),
          (5, [(5,6), (5,8)]),
          (8, [(6,9)])])).


% ========== random geometry ==========

random_doors(Doors) :-
        all_doors(All_doors),
        random_filter(20, All_doors, Doors).

all_doors(Ds) :- findall((From, To), move_undirected(3, From, To), Ds).

random_filter(_, [], []) :- !.
random_filter(Percentage, [X|Xs], [X|Rest]) :- random_guard(Percentage), !, random_filter(Percentage, Xs, Rest).
random_filter(T, [_|Xs], Ys) :- random_filter(T, Xs, Ys).

random_guard(Percentage) :- R is random(100), R < Percentage.

few_random_doors(Doors) :- all_doors(All_doors), few_random_doors(80, All_doors, Doors).

few_random_doors(_, [], []) :- !.
few_random_doors(Percentage, Available_doors, [Door|Rest]) :- 
        random_guard(Percentage),
        length(Available_doors, L),
        I is random(L),
        pick_nth0(I, Available_doors, Door, Remaining_doors),
        P2 is Percentage * Percentage / 100, !,
        few_random_doors(P2, Remaining_doors, Rest).
few_random_doors(_, _, []).

pick_nth0(0, [H|T], H, T).
pick_nth0(N, [H|T], X, [H|T2]) :- N > 0, N2 is N - 1, pick_nth0(N2, T, X, T2).

random_doorknobs(Doorknobs) :- random_doorknobs([1,2,3,4,5,6,7,8], Doorknobs).
random_doorknobs([], []).
random_doorknobs([N|Ns], [(N, Doors)|Rest]) :-
        few_random_doors(Doors),
        random_doorknobs(Ns, Rest).

random_puzzle((Open_doors, Doorknobs)) :- 
        random_doors(Open_doors),
        random_doorknobs(Doorknobs).

random_solvable_puzzle(MinLength, P, S) :-
        random_puzzle(P),
        solve_breadth_first(P, S), 
        length(S, L),
        L > MinLength.
random_solvable_puzzle(MinLength, P, S) :- random_solvable_puzzle(MinLength, P, S).
        
random_solvable_puzzle(MinLength, P, S, C) :- 
        random_solvable_puzzle(MinLength, P, S),
        encode(P, C).
random_solvable_puzzle(MinLength, P, S, C) :- random_solvable_puzzle(MinLength, P, S, C).

% ----------

p(([(1,2),(2,3),(1,4),(2,5),(4,5),(4,7)],[(1,[]),(2,[(1,2)]),(3,[(2,5)]),(4,[(5,6),(6,9)]),(5,[(6,9)]),(6,[(1,4)]),(7,[(7,8)]),(8,[(1,2),(5,6)])])).

% ========== "numeric" encoding ==========

door_code((1,2), 1).
door_code((2,3), 2).
door_code((1,4), 4).
door_code((2,5), 8).
door_code((3,6), 16).
door_code((4,5), 32).
door_code((5,6), 64).
door_code((4,7), 128).
door_code((5,8), 256).
door_code((6,9), 512).
door_code((7,8), 1024).
door_code((8,9), 2048).

encode((Open_doors, Doorknobs), code(X1, X2, X3)) :-
        encode_doors(Open_doors, Xc), 
        X1 is 4095 - Xc,
        encode_doorknobs([1,2,3,4], 1, Doorknobs, X2),
        encode_doorknobs([5,6,7,8], 1, Doorknobs, X3).

encode_doors([], 0).
encode_doors([D|Ds], Sum) :-
        door_code(D, X),
        encode_doors(Ds, S),
        Sum is S + X.

encode_doorknobs([], _, _, 0).
encode_doorknobs([Room|Rs], P, Doorknobs, Sum) :-
        lookup(Room, Doorknobs, Doors),
        encode_doors(Doors, X),
        P2 is P * 4096,
        encode_doorknobs(Rs, P2, Doorknobs, S),
        Sum is P * X + S.
        
lookup(_, [], []).
lookup(Room, [(Room,Doors)|_], Doors) :- !.
lookup(Room, [_|Rest], Doors) :- lookup(Room, Rest, Doors).

% ----- decoding -----

decode_doors(X, L) :- decode_doors(X, 1, L).
decode_doors(_, 4096, []) :- !.
decode_doors(X, B, [Door|Rest]) :- 
        Bit is X /\ B,
        door_code(Door, Bit), !,
        B2 is B * 2,
        decode_doors(X, B2, Rest).
decode_doors(X, B, L) :-
        B2 is B * 2,
        decode_doors(X, B2, L).

decode(code(X1, X2, X3), (Open_Doors, Doorknobs)) :- 
        Xc is 4095 - X1,
        decode_doors(Xc, Open_Doors),
        decode_doorknobs(X2, [1,2,3,4], 1, DK1),
        decode_doorknobs(X3, [5,6,7,8], 1, DK2),
        append(DK1, DK2, Doorknobs).

decode_doorknobs(_, [], _ , []).
decode_doorknobs(X, [H|T], P , [(H,Doors)|Rest]) :-
        D is ((4095 * P) /\ X) / P,
        decode_doors(D, Doors),
        P2 is P * 4096,
        decode_doorknobs(X, T, P2 , Rest).

% ----- dump "loads" of puzzles -----

dump(MinLength, N) :-
        N > 0,
        random_solvable_puzzle(MinLength, _, _, code(X1, X2, X3)), !,
        write(X1), write(' '), write(X2), write(' '), write(X3), nl,
        N1 is N - 1,
        dump(MinLength, N1).

% How to read the result into SmallTalk?
%
% (1)
% f _ FileStream oldFileNamed: '/tmp/puzzles'.
% s _ f contentsOfEntireFile.
% f close
%
% (s findTokens: Character lf) do: [ :line |
% 	level _  level13118 usableSiblingInstance  player.
% 	details _ (line findTokens: ' ') collect: [ :x | x  asNumber ].
% 	level setDoors: (details at: 1);
%                  setWiring1: (details at: 2);
% 		 setWiring2: (details at: 3).
% 	levelholder2778 player include: level.
% ]

% --------------------------------------------------------------------------------

% Problems with more than 30 moves
% 3959 8900313088268 1237290913968
% 3806 292091348513 5635080980736
% 3070 1246094721026 70373041258496
% 4027 75179163920 5650101051396
% 4025 71940718614 88133345482753
% 4070 4433618419712 137733373952
% 3033 213586576211968 4535503306850
% 2745 6736731848704 15099498628
% 2925 44255347212311 68737302670
% 3775 833223786757 286726815744

% LOCAL Variables:  
% mode: prolog 
% coding: iso-latin-1 
% End:  
