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
	STRING
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
void accept(TYPE type, T value);
void accept(TYPE type, char* value);

// 无法识别，报错
void error(string message);

// 根据value返回名称
string paserKey(int value);
string paserDelimitier(int value);
string paserArithmeticOperator(int value);

%}

%%

"auto"				{ accept(KEY, AUTO); }
"break"				{ accept(KEY, BREAK); }
"case"				{ accept(KEY, CASE); }
"char"				{ accept(KEY, CHAR); }
"const"				{ accept(KEY, CONST); }
"continue"			{ accept(KEY, CONTINUE); }
"default"			{ accept(KEY, DEFAULT); }
"do"				{ accept(KEY, DO); }
"double"			{ accept(KEY, DOUBLE); }
"else"				{ accept(KEY, ELSE); }
"enum"				{ accept(KEY, ENUM); }
"extern"			{ accept(KEY, EXTERN); }
"float"				{ accept(KEY, FLOAT); }
"for"				{ accept(KEY, FOR); }
"goto"				{ accept(KEY, GOTO); }
"if"				{ accept(KEY, IF); }
"inline"			{ accept(KEY, INLINE); }
"int"				{ accept(KEY, INT); }
"long"				{ accept(KEY, LONG); }
"register"			{ accept(KEY, REGISTER); }
"restrict"			{ accept(KEY, RESTRICT); }
"return"			{ accept(KEY, RETURN); }
"short"				{ accept(KEY, SHORT); }
"signed"			{ accept(KEY, SIGNED); }
"sizeof"			{ accept(KEY, SIZEOF); }
"static"			{ accept(KEY, STATIC); }
"struct"			{ accept(KEY, STRUCT); }
"switch"			{ accept(KEY, SWITCH); }
"typedef"			{ accept(KEY, TYPEDEF); }
"union"				{ accept(KEY, UNION); }
"unsigned"			{ accept(KEY, UNSIGNED); }
"void"				{ accept(KEY, VOID); }
"volatile"			{ accept(KEY, VOLATILE); }
"while"				{ accept(KEY, WHILE); }
"_Alignas"			{ accept(KEY, _ALIGNAS); }
"_Alignof"			{ accept(KEY, _ALIGNOF); }
"_Atomic"			{ accept(KEY, _ATOMIC); }
"_Bool"				{ accept(KEY, _BOOL); }
"_Complex"			{ accept(KEY, _COMPLEX); }
"_Generic"			{ accept(KEY, _GENERIC); }
"_Imaginary"		{ accept(KEY, _IMAGINARY);}
"_Noreturn"			{ accept(KEY, _NORETURN); }
"_Static_assert" 	{ accept(KEY, _STATIC_ASSERT); }
"_Thread_local"		{ accept(KEY, _THREAD_LOCAL); }

"..."				{ accept(DELIMITER, ELLIPSIS); }
";"					{ accept(DELIMITER, SEMICOLON); }
","					{ accept(DELIMITER, COMMA); }
":"					{ accept(DELIMITER, COLON); }
"("					{ accept(DELIMITER, LEFT_BRACKET); }
")"					{ accept(DELIMITER, RIGHT_BRACKET); }
"["					{ accept(DELIMITER, LEFT_SQUARE_BRACKET); }
"]"					{ accept(DELIMITER, LEFT_SQUARE_BRACKET); }
"{"					{ accept(DELIMITER, LEFT_CURLY_BRACKET); }
"}"					{ accept(DELIMITER, RIGHT_CURLY_BRACKET); }
"<"					{ accept(DELIMITER, LEFT_ANGLE_BRACKET); }
">"					{ accept(DELIMITER, RIGHT_ANGLE_BRACKET); }
"."					{ accept(DELIMITER, DOT); }
"?"					{ accept(DELIMITER, QUESTION_MARK); }
"#"					{ accept(DELIMITER, HASHTAG); }
"/*"				{ accept(DELIMITER, LEFT_COMMENT); }
"*/"				{ accept(DELIMITER, RIGHT_COMMENT); }
"//"				{ accept(DELIMITER, COMMENT); }

">>="				{ accept(ARITHMETIC_OPERATOR, RIGHT_ASSIGN); }
"<<="				{ accept(ARITHMETIC_OPERATOR, LEFT_ASSIGN); }
"+="				{ accept(ARITHMETIC_OPERATOR, ADD_ASSIGN); }
"-="				{ accept(ARITHMETIC_OPERATOR, SUB_ASSIGN); }
"*="				{ accept(ARITHMETIC_OPERATOR, MUL_ASSIGN); }
"/="				{ accept(ARITHMETIC_OPERATOR, DIV_ASSIGN); }
"%="				{ accept(ARITHMETIC_OPERATOR, MOD_ASSIGN); }
"&="				{ accept(ARITHMETIC_OPERATOR, AND_ASSIGN); }
"^="				{ accept(ARITHMETIC_OPERATOR, XOR_ASSIGN); }
"|="				{ accept(ARITHMETIC_OPERATOR, OR_ASSIGN); }
">>"				{ accept(ARITHMETIC_OPERATOR, RIGHT_OP); }
"<<"				{ accept(ARITHMETIC_OPERATOR, LEFT_OP); }
"++"				{ accept(ARITHMETIC_OPERATOR, INC_OP); }
"--"				{ accept(ARITHMETIC_OPERATOR, DEC_OP); }
"->"				{ accept(ARITHMETIC_OPERATOR, PTR_OP); }
"&&"				{ accept(ARITHMETIC_OPERATOR, AND_OP); }
"||"				{ accept(ARITHMETIC_OPERATOR, OR_OP); }
"<="				{ accept(ARITHMETIC_OPERATOR, LE_OP); }
">="				{ accept(ARITHMETIC_OPERATOR, GE_OP); }
"=="				{ accept(ARITHMETIC_OPERATOR, EQ_OP); }
"!="				{ accept(ARITHMETIC_OPERATOR, NE_OP); }
"="					{ accept(ARITHMETIC_OPERATOR, EQ); }
"&"					{ accept(ARITHMETIC_OPERATOR, AND); }
"|"					{ accept(ARITHMETIC_OPERATOR, OR); }
"!"					{ accept(ARITHMETIC_OPERATOR, NOT); }
"^"					{ accept(ARITHMETIC_OPERATOR, XOR); }
"+"					{ accept(ARITHMETIC_OPERATOR, ADD); }
"-"					{ accept(ARITHMETIC_OPERATOR, SUB); }
"*"					{ accept(ARITHMETIC_OPERATOR, MUL); }
"/"					{ accept(ARITHMETIC_OPERATOR, DIV); }
"%"					{ accept(ARITHMETIC_OPERATOR, MOD); }

{L}({L}|{D})*		{ accept(IDENTIFIER, yytext); }

0[xX]{H}+{IS}?		{ accept(CONSTANT, atoi(yytext)); }
0{D}+{IS}?			{ accept(CONSTANT, atoi(yytext)); }
{D}+{IS}?			{ accept(CONSTANT, atoi(yytext)); }
L?'(\\.|[^\\'])+'	{ accept(CONSTANT, atoi(yytext)); }

{D}+{E}{FS}?			{ accept(REAL, atof(yytext)); }
{D}*"."{D}+({E})?{FS}?	{ accept(REAL, atof(yytext)); }
{D}+"."{D}*({E})?{FS}?	{ accept(REAL, atof(yytext)); }

L?\"(\\.|[^\\"])*\"		{ accept(STRING, yytext); }

[ \t\v\n\f]				{ /*空白符，直接忽略*/ }

{D}({L}|{D})*			{ error("非法的标识符" + string(yytext)); }

.						{ error("无法识别" + string(yytext)); }

%%

template<typename T>
void accept(TYPE type, T value)
{
	if(isDetail)
	{
		if(type == KEY || type == DELIMITER || type == ARITHMETIC_OPERATOR)
		{
			string typeName, valueName;
			switch(type)
			{
			case KEY:
				typeName = "关键字";
				valueName = paserKey((int)value);
				break;
			case DELIMITER:
				typeName = "分界符";
				valueName = paserDelimitier((int)value);
				break;
			case ARITHMETIC_OPERATOR:
				typeName = "运算符";
				valueName = paserArithmeticOperator((int)value);
				break;
			default:
				break;
			}
			cout << (Index++) << " " << typeName << " " << valueName << endl;
		}
		else if(type == CONSTANT || type == REAL)
		{
			string typeName;
			switch(type)
			{
			case CONSTANT:
				typeName = "整形数";
				break;
			case REAL:
				typeName = "浮点数";
				break;
			default:
				break;
			}
			cout << (Index++) << " " << typeName << " " << value << endl;
		}
	}
	else
	{
		cout << (Index++) << " " << type << " " << value << endl;
	}
}
void accept(TYPE type, char* value)
{
	if(isDetail)
	{
		string typeName = "字符串";
		switch(type)
		{
		case STRING:
			typeName = "字符串";
			break;
		case IDENTIFIER:
			typeName = "标识符";
			break;
		default:
			break;
		}
		cout << (Index++) << " " << typeName << " " << value << endl;
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

string paserKey(int value)
{
	string valueName;
	switch(value)
	{
	case AUTO:
		valueName = "auto";
		break;
	case BREAK:
		valueName = "break";
		break;
	case CASE:
		valueName = "case";
		break;
	case CHAR:
		valueName = "char";
		break;
	case CONST:
		valueName = "const";
		break;
	case CONTINUE:
		valueName = "continue";
		break;
	case DEFAULT:
		valueName = "default";
		break;
	case DO:
		valueName = "do";
		break;
	case DOUBLE:
		valueName = "double";
		break;
	case ELSE:
		valueName = "else";
		break;
	case ENUM:
		valueName = "enum";
		break;
	case EXTERN:
		valueName = "extern";
		break;
	case FLOAT:
		valueName = "float";
		break;
	case FOR:
		valueName = "for";
		break;
	case GOTO:
		valueName = "goto";
		break;
	case IF:
		valueName = "if";
		break;
	case INLINE:
		valueName = "inline";
		break;
	case INT:
		valueName = "int";
		break;
	case LONG:
		valueName = "long";
		break;
	case REGISTER:
		valueName = "register";
		break;
	case RESTRICT:
		valueName = "restrict";
		break;
	case RETURN:
		valueName = "return";
		break;
	case SHORT:
		valueName = "short";
		break;
	case SIGNED:
		valueName = "signed";
		break;
	case SIZEOF:
		valueName = "sizeof";
		break;
	case STATIC:
		valueName = "static";
		break;
	case STRUCT:
		valueName = "struct";
		break;
	case SWITCH:
		valueName = "switch";
		break;
	case TYPEDEF:
		valueName = "typedef";
		break;
	case UNION:
		valueName = "union";
		break;
	case UNSIGNED:
		valueName = "unsigned";
		break;
	case VOID:
		valueName = "void";
		break;
	case VOLATILE:
		valueName = "volatile";
		break;
	case WHILE:
		valueName = "while";
		break;
	case _ALIGNAS:
		valueName = "_Alignas";
		break;
	case _ALIGNOF:
		valueName = "_Alignof";
		break;
	case _ATOMIC:
		valueName = "_Atomic";
		break;
	case _BOOL:
		valueName = "_Bool";
		break;
	case _COMPLEX:
		valueName = "_Complex";
		break;
	case _GENERIC:
		valueName = "_Generic";
		break;
	case _IMAGINARY:
		valueName = "_Imaginary";
		break;
	case _NORETURN:
		valueName = "_Noreturn";
		break;
	case _STATIC_ASSERT:
		valueName = "_Static_assert";
		break;
	case _THREAD_LOCAL:
		valueName = "_Thread_local";
		break;
	}
	return valueName;
}

string paserDelimitier(int value)
{
	string valueName;
	switch(value)
	{
	case ELLIPSIS:
		valueName = "...";
		break;
	case SEMICOLON:
		valueName = ";";
		break;
	case COMMA:
		valueName = ",";
		break;
	case COLON:
		valueName = ":";
		break;
	case LEFT_BRACKET:
		valueName = "(";
		break;
	case RIGHT_BRACKET:
		valueName = ")";
		break;
	case LEFT_SQUARE_BRACKET:
		valueName = "[";
		break;
	case RIGHT_SQUARE_BRACKET:
		valueName = "]";
		break;
	case LEFT_CURLY_BRACKET:
		valueName = "{";
		break;
	case RIGHT_CURLY_BRACKET:
		valueName = "}";
		break;
	case LEFT_ANGLE_BRACKET:
		valueName = "<";
		break;
	case RIGHT_ANGLE_BRACKET:
		valueName = ">";
		break;
	case DOT:
		valueName = ".";
		break;
	case QUESTION_MARK:
		valueName = "?";
		break;
	case HASHTAG:
		valueName = "#";
		break;
	case LEFT_COMMENT:
		valueName = "/*";
		break;
	case RIGHT_COMMENT:
		valueName = "*/";
		break;
	case COMMENT:
		valueName = "//";
		break;
	}
	return valueName;
}

string paserArithmeticOperator(int value)
{
	string valueName;
	switch(value)
	{
	case RIGHT_ASSIGN:
		valueName = ">>=";
		break;
	case LEFT_ASSIGN:
		valueName = "<<=";
		break;
	case ADD_ASSIGN:
		valueName = "+=";
		break;
	case SUB_ASSIGN:
		valueName = "-=";
		break;
	case MUL_ASSIGN:
		valueName = "*=";
		break;
	case DIV_ASSIGN:
		valueName = "/=";
		break;
	case MOD_ASSIGN:
		valueName = "%=";
		break;
	case AND_ASSIGN:
		valueName = "&=";
		break;
	case XOR_ASSIGN:
		valueName = "^=";
		break;
	case OR_ASSIGN:
		valueName = "|=";
		break;
	case RIGHT_OP:
		valueName = ">>";
		break;
	case LEFT_OP:
		valueName = "<<";
		break;
	case INC_OP:
		valueName = "++";
		break;
	case DEC_OP:
		valueName = "--";
		break;
	case PTR_OP:
		valueName = "->";
		break;
	case AND_OP:
		valueName = "&&";
		break;
	case OR_OP:
		valueName = "||";
		break;
	case LE_OP:
		valueName = "<=";
		break;
	case GE_OP:
		valueName = ">=";
		break;
	case EQ_OP:
		valueName = "==";
		break;
	case NE_OP:
		valueName = "!=";
		break;
	case EQ:
		valueName = "=";
		break;
	case AND:
		valueName = "&";
		break;
	case OR:
		valueName = "|";
		break;
	case NOT:
		valueName = "!";
		break;
	case XOR:
		valueName = "^";
		break;
	case ADD:
		valueName = "+";
		break;
	case SUB:
		valueName = "-";
		break;
	case MUL:
		valueName = "*";
		break;
	case DIV:
		valueName = "/";
		break;
	case MOD:
		valueName = "%";
		break;
	}
	return valueName;
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
