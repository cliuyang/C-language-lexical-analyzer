%option noyywrap
%option c++
%option yyclass="NLexer"

D			[0-9]
L			[a-zA-Z_]
H			[a-fA-F0-9]
E			[Ee][+-]?{D}+
FS			(f|F|l|L)
IS			(u|U|l|L)*

%{
#include <cstdio>
#include <cstring>
#include <iostream>

using namespace std;

class NLexer : public yyFlexLexer
{
public:
    virtual int yylex();
};

typedef enum
{
	KEY,
	IDENTIFIER,
	DELIMITER,
	ARITHMETIC_OPERATOR,
	CONSTANT,
	REAL,
	STRING,
	CHARACTER
}TYPE;

typedef enum
{
	AUTO, BREAK, CASE, CHAR, CONST, CONTINUE, DEFAULT, DO, DOUBLE, ELSE,ENUM, EXTERN, FLOAT, FOR, GOTO, IF, INLINE, INT, LONG, REGISTER, RESTRICT, RETURN, SHORT, SIGNED, SIZEOF, STATIC, STRUCT, SWITCH, TYPEDEF, UNION, UNSIGNED, VOID, VOLATILE, WHILE, _ALIGNAS, _ALIGNOF, _ATOMIC, _BOOL, _COMPLEX, _GENERIC, _IMAGINARY, _NORETURN, _STATIC_ASSERT, _THREAD_LOCAL
}key;

typedef enum
{
	ELLIPSIS, SEMICOLON, COMMA, COLON, LEFT_BRACKET, RIGHT_BRACKET, LEFT_SQUARE_BRACKET, RIGHT_SQUARE_BRACKET, LEFT_CURLY_BRACKET, RIGHT_CURLY_BRACKET, LEFT_ANGLE_BRACKET, RIGHT_ANGLE_BRACKET, DOT, QUESTION_MARK, HASHTAG, LEFT_COMMENT, RIGHT_COMMENT, COMMENT
}delimiter;

typedef enum 
{
	RIGHT_ASSIGN, LEFT_ASSIGN, ADD_ASSIGN, SUB_ASSIGN, MUL_ASSIGN, DIV_ASSIGN, MOD_ASSIGN, AND_ASSIGN, XOR_ASSIGN, OR_ASSIGN, RIGHT_OP, LEFT_OP, INC_OP, DEC_OP, PTR_OP, AND_OP, OR_OP, LE_OP, GE_OP, EQ_OP, NE_OP, EQ, AND, OR, NOT, XOR, ADD, SUB, MUL, DIV, MOD
}arithmetic_operator;

int Index = 0;
bool isDetail = false;

// 识别出来后，接受单词
template<typename T>
void accept(TYPE type, char* text, T value);

// 无法识别，报错
void error(string message);

%}

%%

"auto"				{ accept(KEY, yytext, AUTO); }
"break"				{ accept(KEY, yytext, BREAK); }
"case"				{ accept(KEY, yytext, CASE); }
"char"				{ accept(KEY, yytext, CHAR); }
"const"				{ accept(KEY, yytext, CONST); }
"continue"			{ accept(KEY, yytext, CONTINUE); }
"default"			{ accept(KEY, yytext, DEFAULT); }
"do"				{ accept(KEY, yytext, DO); }
"double"			{ accept(KEY, yytext, DOUBLE); }
"else"				{ accept(KEY, yytext, ELSE); }
"enum"				{ accept(KEY, yytext, ENUM); }
"extern"			{ accept(KEY, yytext, EXTERN); }
"float"				{ accept(KEY, yytext, FLOAT); }
"for"				{ accept(KEY, yytext, FOR); }
"goto"				{ accept(KEY, yytext, GOTO); }
"if"				{ accept(KEY, yytext, IF); }
"inline"			{ accept(KEY, yytext, INLINE); }
"int"				{ accept(KEY, yytext, INT); }
"long"				{ accept(KEY, yytext, LONG); }
"register"			{ accept(KEY, yytext, REGISTER); }
"restrict"			{ accept(KEY, yytext, RESTRICT); }
"return"			{ accept(KEY, yytext, RETURN); }
"short"				{ accept(KEY, yytext, SHORT); }
"signed"			{ accept(KEY, yytext, SIGNED); }
"sizeof"			{ accept(KEY, yytext, SIZEOF); }
"static"			{ accept(KEY, yytext, STATIC); }
"struct"			{ accept(KEY, yytext, STRUCT); }
"switch"			{ accept(KEY, yytext, SWITCH); }
"typedef"			{ accept(KEY, yytext, TYPEDEF); }
"union"				{ accept(KEY, yytext, UNION); }
"unsigned"			{ accept(KEY, yytext, UNSIGNED); }
"void"				{ accept(KEY, yytext, VOID); }
"volatile"			{ accept(KEY, yytext, VOLATILE); }
"while"				{ accept(KEY, yytext, WHILE); }
"_Alignas"			{ accept(KEY, yytext, _ALIGNAS); }
"_Alignof"			{ accept(KEY, yytext, _ALIGNOF); }
"_Atomic"			{ accept(KEY, yytext, _ATOMIC); }
"_Bool"				{ accept(KEY, yytext, _BOOL); }
"_Complex"			{ accept(KEY, yytext, _COMPLEX); }
"_Generic"			{ accept(KEY, yytext, _GENERIC); }
"_Imaginary"		{ accept(KEY, yytext, _IMAGINARY);}
"_Noreturn"			{ accept(KEY, yytext, _NORETURN); }
"_Static_assert" 	{ accept(KEY, yytext, _STATIC_ASSERT); }
"_Thread_local"		{ accept(KEY, yytext, _THREAD_LOCAL); }

"..."				{ accept(DELIMITER, yytext, ELLIPSIS); }
";"					{ accept(DELIMITER, yytext, SEMICOLON); }
","					{ accept(DELIMITER, yytext, COMMA); }
":"					{ accept(DELIMITER, yytext, COLON); }
"("					{ accept(DELIMITER, yytext, LEFT_BRACKET); }
")"					{ accept(DELIMITER, yytext, RIGHT_BRACKET); }
"["					{ accept(DELIMITER, yytext, LEFT_SQUARE_BRACKET); }
"]"					{ accept(DELIMITER, yytext, LEFT_SQUARE_BRACKET); }
"{"					{ accept(DELIMITER, yytext, LEFT_CURLY_BRACKET); }
"}"					{ accept(DELIMITER, yytext, RIGHT_CURLY_BRACKET); }
"<"					{ accept(DELIMITER, yytext, LEFT_ANGLE_BRACKET); }
">"					{ accept(DELIMITER, yytext, RIGHT_ANGLE_BRACKET); }
"."					{ accept(DELIMITER, yytext, DOT); }
"?"					{ accept(DELIMITER, yytext, QUESTION_MARK); }
"#"					{ accept(DELIMITER, yytext, HASHTAG); }
"/*"				{ accept(DELIMITER, yytext, LEFT_COMMENT); }
"*/"				{ accept(DELIMITER, yytext, RIGHT_COMMENT); }
"//"				{ accept(DELIMITER, yytext, COMMENT); }

">>="				{ accept(ARITHMETIC_OPERATOR, yytext, RIGHT_ASSIGN); }
"<<="				{ accept(ARITHMETIC_OPERATOR, yytext, LEFT_ASSIGN); }
"+="				{ accept(ARITHMETIC_OPERATOR, yytext, ADD_ASSIGN); }
"-="				{ accept(ARITHMETIC_OPERATOR, yytext, SUB_ASSIGN); }
"*="				{ accept(ARITHMETIC_OPERATOR, yytext, MUL_ASSIGN); }
"/="				{ accept(ARITHMETIC_OPERATOR, yytext, DIV_ASSIGN); }
"%="				{ accept(ARITHMETIC_OPERATOR, yytext, MOD_ASSIGN); }
"&="				{ accept(ARITHMETIC_OPERATOR, yytext, AND_ASSIGN); }
"^="				{ accept(ARITHMETIC_OPERATOR, yytext, XOR_ASSIGN); }
"|="				{ accept(ARITHMETIC_OPERATOR, yytext, OR_ASSIGN); }
">>"				{ accept(ARITHMETIC_OPERATOR, yytext, RIGHT_OP); }
"<<"				{ accept(ARITHMETIC_OPERATOR, yytext, LEFT_OP); }
"++"				{ accept(ARITHMETIC_OPERATOR, yytext, INC_OP); }
"--"				{ accept(ARITHMETIC_OPERATOR, yytext, DEC_OP); }
"->"				{ accept(ARITHMETIC_OPERATOR, yytext, PTR_OP); }
"&&"				{ accept(ARITHMETIC_OPERATOR, yytext, AND_OP); }
"||"				{ accept(ARITHMETIC_OPERATOR, yytext, OR_OP); }
"<="				{ accept(ARITHMETIC_OPERATOR, yytext, LE_OP); }
">="				{ accept(ARITHMETIC_OPERATOR, yytext, GE_OP); }
"=="				{ accept(ARITHMETIC_OPERATOR, yytext, EQ_OP); }
"!="				{ accept(ARITHMETIC_OPERATOR, yytext, NE_OP); }
"="					{ accept(ARITHMETIC_OPERATOR, yytext, EQ); }
"&"					{ accept(ARITHMETIC_OPERATOR, yytext, AND); }
"|"					{ accept(ARITHMETIC_OPERATOR, yytext, OR); }
"!"					{ accept(ARITHMETIC_OPERATOR, yytext, NOT); }
"^"					{ accept(ARITHMETIC_OPERATOR, yytext, XOR); }
"+"					{ accept(ARITHMETIC_OPERATOR, yytext, ADD); }
"-"					{ accept(ARITHMETIC_OPERATOR, yytext, SUB); }
"*"					{ accept(ARITHMETIC_OPERATOR, yytext, MUL); }
"/"					{ accept(ARITHMETIC_OPERATOR, yytext, DIV); }
"%"					{ accept(ARITHMETIC_OPERATOR, yytext, MOD); }

{L}({L}|{D})*		{ accept(IDENTIFIER, yytext, yytext); }

0[xX]{H}+{IS}?		{ accept(CONSTANT, yytext, atoi(yytext)); }
0{D}+{IS}?			{ accept(CONSTANT, yytext, atoi(yytext)); }
{D}+{IS}?			{ accept(CONSTANT, yytext, atoi(yytext)); }
L?'(\\.|[^\\'])+'	{ accept(CHARACTER, yytext, atoi(yytext)); }

{D}+{E}{FS}?			{ accept(REAL, yytext, atof(yytext)); }
{D}*"."{D}+({E})?{FS}?	{ accept(REAL, yytext, atof(yytext)); }
{D}+"."{D}*({E})?{FS}?	{ accept(REAL, yytext, atof(yytext)); }

L?\"(\\.|[^\\"])*\"		{ accept(STRING, yytext, yytext); }

[ \t\v\n\f]				{ /*空白符，直接忽略*/ }

{D}({L}|{D})*			{ error("非法的标识符" + string(yytext)); }

.						{ error("无法识别" + string(yytext)); }

%%

template<typename T>
void accept(TYPE type, char* text, T value)
{
	if(isDetail)
	{
		if(type == CONSTANT || type == REAL || type == CHARACTER)
		{
			switch(type)
			{
			case CONSTANT:
				cout << (Index++) << " 整形数 " << value << endl;
				break;
			case REAL:
				cout << (Index++) << " 浮点数 " << value << endl;
				break;
			case CHARACTER:
				cout << (Index++) << " 字符型 " << (int)text[1] << endl;
				break;
			default:
				break;
			}
		}
		else
		{
			string typeName;
			switch(type)
			{
			case KEY:
				typeName = "关键字";
				break;
			case DELIMITER:
				typeName = "分界符";
				break;
			case ARITHMETIC_OPERATOR:
				typeName = "运算符";
				break;
			case STRING:
				typeName = "字符串";
				break;
			case IDENTIFIER:
				typeName = "标识符";
				break;
			default:
				break;
			}
			cout << (Index++) << " " << typeName << " " << text << endl;
		}
	}
	else
	{
		cout << (Index++) << " " << type << " " << value << endl;
	}
}

void error(string message)
{
	cout << message << endl;
}

int main()
{
	cout << "请输入展示方式:" << endl;
	cout << "详细信息(/*detail*/)  简略信息(/*breif*/)" << endl;
	string temp;
	getline(cin, temp);
	isDetail = (temp == "/*detail*/");
	NLexer lexer;
	while(lexer.yylex() != 0);
	return 0;
}
