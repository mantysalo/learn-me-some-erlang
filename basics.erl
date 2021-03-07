-module(basics).


numbers_and_variables() ->
    One =
        1, %% Variable names must start with a capital letter.
    Un = Uno = One =
                   1, %% Subsequent expressions are separated with a comma.
    Two = 2,
    _ =
        123, %% This is a throw away variable. The value will not be stored. The underscore variable usually acts as a wildcard for pattern matching.
    Two = Two + 1. %% Expressions end with a dot.

atoms() ->
    %% An atom is referred to in an "atom table" which consumes memory.
    %% The atom table is not garbage collected, and so atoms will accumulate until the system tips over, either from memory usage or because 1048577 atoms were declared.
    %% This means atoms should not be generated dynamically.
    atom, %% This is an atom. Atoms are the reason variables have to start with a capital letter.
          %% Atoms are literals, constants with their own name for value.
    'Atom', %% Atoms should be enclosed in single quotes (') if they do not begin with a lower-case letter or if it contains other characters than alphanumeric characters, underscore (_), or @.
    atom = 'atom'. %% Atom with single quotes is exactly the same as a similar atom without them.

tuples() ->
    X = 10, Y = 4,
    Point = {X,Y},
    PreciseTemperature = {celsius, 23.213}, %% A tuple which contains an atom with one element following it is called a 'tagged tuple'.
    {kelvin, T} = PreciseTemperature, %% This throw an exception: exception error: no match of right hand side value {celsius,23.213}
    %% Any element of a tuple can be of any type, even another tuple:
    {point, Point}.

lists() ->
    %% Lists can contain anything
    MixedList = [1, 2, 3, {numbers,[4,5,6]}, 5.34, atom],
    %% You can combine lists with the ++ operator:
    [1,2,3] ++ [4,5], %% [1,2,3,4,5]
    %% And you can remove items from a list with the -- operator:
    [1,2,3,4,5] -- [1,2,3], %% [4,5]
    %% Both ++ and -- are right-associative. This means the elements of many -- or ++ operations will be done from right to left.
    [1,2,3] -- [1,2] -- [3], %% [3]
    [1,2,3] -- [1,2] -- [2], %% [2,3]
    hd([1,2,3]), %% Returns "head" (first item from list). In this case it's 1.
    tl([1,2,3]), %% Returns "tail" (all other elements except the first). In this case the tail is [2,3]
    %% You can also use pattern matching to access the Head or Tail of a list.
    [Head|Tail] = [1,2,3], %% [1,2,3]
    %% The | used above is called the cons operator (constructor).
    Head, %% 1
    Tail, %% [2,3]
    %% Pattern matching can also be used to add a new head or tail to a list
    List = [2,3],
    NewList = [1|List]. %% [1,2,3]
    
list_comprehensions() ->
    [2*N || N <- [1,2,3,4]], %% [2,4,6,8]
    %% List comprehensions can have conditions:
    [X || X <- [1,2,3,4,5,6,7,8,9,10], X rem 2 =:= 0], %% [2,4,6,8,10]
    %% You can have multiple conditions:
    RestaurantMenu = [{steak, 5.99}, {beer, 3.99}, {poutine, 3.50}, {kitten, 20.99}, {water, 0.00}],
    [{Item, Price*1.07} || {Item, Price} <- RestaurantMenu, Price >= 3, Price =< 10], %% [{steak,6.409300000000001},{beer,4.2693},{poutine,3.745}]
    %% The part Pattern <- List is named a Generator expression. You can have more than one of those as well:
    [X+Y || X <- [1,2], Y <- [2,3]], %% This runs the operations 1+2, 1+3, 2+2, 2+3 and so the final output is [3,4,4,5]
    %% You can also use pattern matching in list comprehensions:
    Weather = [{toronto, rain}, {montreal, storms}, {london, fog}, {paris, sun}, {boston, fog}, {vancouver, snow}],
    [X || {X, fog} <- Weather]. %% [london,boston]
    %% If an element of the list 'Weather' doesn't match the {X, fog} pattern, it's simply ignored in the list comprehension whereas the = operator would have thrown an exception.



