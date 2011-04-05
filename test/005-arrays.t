#! /usr/bin/env escript
% This file is part of eep0018 released under the MIT license. 
% See the LICENSE file for more information.

main([]) ->
    code:add_pathz("ebin"),
    code:add_pathz("test"),
    
    etap:plan(18),
    util:test_good(good()),
    util:test_errors(errors()),
    etap:end_tests().

good() ->
    [
        {<<"[]">>, []},
        {<<"[\t[\n]\r]">>, [[]], <<"[[]]">>},
        {<<"[\t123, \r true\n]">>, [123, true], <<"[123,true]">>},
        {<<"[1,\"foo\"]">>, [1, <<"foo">>]},
        {<<"[1199344435545.0,1]">>, [1199344435545.0,1], <<"[1.19934e+12,1]">>},
        {
            <<"[\"\\u00A1\",\"\\u00FC\"]">>,
            [<<194, 161>>, <<195, 188>>],
            <<"[\"", 194, 161, "\",\"", 195, 188, "\"]">>
        }
    ].

errors() ->
    [
        <<"[">>,
        <<"]">>,
        <<"[,]">>,
        <<"[123">>,
        <<"[123,]">>,
        <<"[32 true]">>
    ].
