HAS_ELIXIR=1
NO_DOC=1
NO_XREF=1

include bu.mk

release: dist lint tag ##Publish a new release
	$(verbose) $(REBAR) hex publish
