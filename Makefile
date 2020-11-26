
build:
	@echo "\n==== COMPILING ====\n"
	ocamlbuild ftest.native

format:
	ocp-indent --inplace src/*

edit:
	code . -n

demo: build
	@echo "\n==== EXECUTING ====\n"
	./ftest.native infos.txt 0 5 outfile


	@echo "\n==== RESULT ==== (content of outfile) \n"
	@cat outfile
	dot -Tsvg outfile.dot > outfile.svg 

clean:
	-rm -rf _build/
	-rm ftest.native

