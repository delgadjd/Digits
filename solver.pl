% Define the initial state of the problem.
start([N1, N2, N3, N4, N5, N6], Goal) :-
    % The initial state consists of 6 numbers and a goal number.
    % The numbers can be any positive integers.
    % The goal number is the number we want to reach by applying operations to the other numbers.
    Goal > 0,
    N1 > 0, N2 > 0, N3 > 0, N4 > 0, N5 > 0, N6 > 0,
    % Call the solve/2 predicate to solve the problem.
    solve([N1, N2, N3, N4, N5, N6], Goal, []).

% Base case: If we have only one number left and it is equal to the goal, we have found a solution.
solve([Goal|_], Goal, Operations) :-
    % Print the list of operations that led to the solution.
    write(Operations), nl.

% Recursive case: Apply an operation to two numbers and add the result to the list of numbers.
solve(Numbers, Goal, Operations) :-
    % Select two numbers from the list.
    select(Number1, Numbers, Numbers1),
    select(Number2, Numbers1, Numbers2),
    % Apply one of the four possible operations.
    (Addition is Number1 + Number2, Addition > 0, solve([Addition|Numbers2], Goal, ['+'(Number1, Number2)|Operations]);
     Subtraction is Number1 - Number2, Subtraction > 0, solve([Subtraction|Numbers2], Goal, ['-'(Number1, Number2)|Operations]);
     Multiplication is Number1 * Number2, Multiplication > 0, solve([Multiplication|Numbers2], Goal, ['*'(Number1, Number2)|Operations]);
     Number2 =\= 0, Division is Number1 / Number2, Division > 0, solve([Division|Numbers2], Goal, ['/'(Number1, Number2)|Operations])).

% Select one element from the list and return the remaining elements as the second argument.
select(X, [X|Xs], Xs).
select(X, [Y|Ys], [Y|Zs]) :- select(X, Ys, Zs).