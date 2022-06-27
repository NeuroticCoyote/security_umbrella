security
=====
USES GITHUB ACTIONS FOR PR REVIEWS AND BRANCH PUSHES

Commands
-----
To Build:
    $ rebar3 compile

To Run:
    $ rebar3 shell

To Release:
    $ rebar3 release

To run the release in the foreground:
    $  ./_build/default/rel/security/bin/security foreground
To stop
    $ ./_build/default/rel/security/bin/security stop
To run in the shell
    $ ./_build/default/rel/security/bin/security console

Docker
-----
To build:
    $ docker build -t my_erl_builder:latest .

To Run:
    $ docker run -it my_erl_builder:latest /bin/sh