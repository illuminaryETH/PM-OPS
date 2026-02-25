.PHONY: test test-structure test-templates test-crossref test-alignment test-consistency test-markdown

test:
	@bash tests/run_tests.sh

test-structure:
	@bash tests/run_tests.sh structure

test-templates:
	@bash tests/run_tests.sh templates

test-crossref:
	@bash tests/run_tests.sh crossref

test-alignment:
	@bash tests/run_tests.sh alignment

test-consistency:
	@bash tests/run_tests.sh consistency

test-markdown:
	@bash tests/run_tests.sh markdown
