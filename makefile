all: lex.yy.c
	gcc lex.yy.c
lex.yy.c: 
	lex $(HW)
run:
	./a.out
clean:
	rm -r *.out *.c
