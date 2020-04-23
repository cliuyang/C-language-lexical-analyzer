lex -+ lex.l
clang++ lex.yy.cc -o lex.out
rm ./lex.yy.cc
./lex.out
