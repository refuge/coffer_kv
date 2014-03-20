ERL          ?= erl
ERLC	     ?= erlc
APP          := coffer_kv
REBAR?=./rebar

.PHONY: deps

all: deps compile

clean:
	@$(REBAR) clean

compile:
	@$(REBAR) compile

deps:
	@$(REBAR) get-deps

distclean: clean
	@$(REBAR) delete-deps
	@rm -rf deps

dialyzer: compile
	@dialyzer -Wno_return -c ebin

check:
	@$(REBAR) eunit

