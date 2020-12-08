build:
	@echo "\n==== COMPILING ====\n"
	ocamlbuild ftest.native
	ocamlbuild share_money_test.native


build_ff:
	@echo "\n==== COMPILING ====\n"
	ocamlbuild ftest.native

build_ms:
	@echo "\n==== COMPILING ====\n"
	ocamlbuild share_money_test.native

demo_ff: build_ff
	@echo "\n==== EXECUTING ====\n"
	./ftest.native test_set/Ford_Fulkerson/graph1 0 5 demo_ff


	@echo "\n==== RESULT ==== (content of outfile) \n"
	@cat demo_ff
	@dot -Tsvg demo_ff.dot > demo_ff.svg 
	@rm demo_ff.dot

demo_ms: build_ms
	@echo "\n==== EXECUTING ====\n"
	./share_money_test.native test_set/money_sharing/money_sharing_1.txt demo_ms.txt 
	
	@echo "\n==== RESULT ==== (content of outfile) \n"
	@cat demo_ms.txt
	@dot -Tsvg demo_ms.txt.dot > demo_ms.svg 
	@rm demo_ms.txt.dot

clean:
	-rm -rf _build/
	-rm ftest.native
	-rm share_money_test.native

