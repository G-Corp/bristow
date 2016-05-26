PROJECT = bristow

DEP_PLUGINS = mix.mk
BUILD_DEPS = mix.mk
ELIXIR_VERSION = ~> 1.2
dep_mix.mk = git https://github.com/botsunit/mix.mk.git master

include erlang.mk

release: app mix.exs

