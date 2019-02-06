# Base directory
SRC_DIR=src
BIN_DIR=bin
GEN_DIR=gen
# Files' names
CPP_EXTENSION=cpp
HPP_EXTENSION=hpp
LEXER_IN_NAME=lexer
LEXER_OUT_NAME=lexer
PARSER_IN_NAME=parser
PARSER_OUT_NAME=parser
TOKENIZER_IN_NAME=tokenizer
TOKENIZER_OUT_NAME=tokenizer
TESTPARSER_IN_NAME=testparser
TESTPARSER_OUT_NAME=testparser
SRC_LEXER=${SRC_DIR}/${LEXER_IN_NAME}.l++
SRC_PARSER=${SRC_DIR}/${PARSER_IN_NAME}.yy
CPP_LEXER=${GEN_DIR}/${LEXER_OUT_NAME}.${CPP_EXTENSION}
HPP_LEXER=${GEN_DIR}/${LEXER_OUT_NAME}.${HPP_EXTENSION}
CPP_PARSER=${GEN_DIR}/${PARSER_OUT_NAME}.${CPP_EXTENSION}
LEXER_FSM=${GEN_DIR}/lexer_fsm
CPP_LEXER_FSM=${LEXER_FSM}.${CPP_EXTENSION}
CPP_TOKENIZER=${SRC_DIR}/${TOKENIZER_IN_NAME}.${CPP_EXTENSION}
CPP_TESTPARSER=${SRC_DIR}/${TESTPARSER_IN_NAME}.${CPP_EXTENSION}
SRC_PARSING_FILES=${CPP_PARSER} ${CPP_LEXER} ${CPP_LEXER_FSM}
TOKENIZER_OUT=${BIN_DIR}/${TOKENIZER_OUT_NAME}
TESTPARSER_OUT=${BIN_DIR}/${TESTPARSER_OUT_NAME}
# Compiler options
CC=g++
CC_LIB_DIR=/home/pt/tools/reflex/lib
CC_INC_DIR=/home/pt/tools/reflex/include
# Targets
all: testparser tokenizer

tokenizer: genlexer genparser bindir
	${CC} -o ${TOKENIZER_OUT} -L ${CC_LIB_DIR} -I ${GEN_DIR} -I ${CC_INC_DIR} ${CPP_TOKENIZER} ${SRC_PARSING_FILES} -lreflex

testparser: genlexer genparser bindir
	${CC} -o ${TESTPARSER_OUT} -L ${CC_LIB_DIR} -I ${GEN_DIR} -I ${CC_INC_DIR} ${CPP_TESTPARSER} ${SRC_PARSING_FILES} -lreflex

debugparser: genlexer gendebugparser bindir
	${CC} -o ${TESTPARSER_OUT} -L ${CC_LIB_DIR} -I ${GEN_DIR} -I ${CC_INC_DIR} ${CPP_TESTPARSER} ${SRC_PARSING_FILES} -lreflex

genlexer: ${SRC_LEXER} gendir
	reflex -o ${CPP_LEXER} --tables-file=${LEXER_FSM} --header-file=${HPP_LEXER} ${SRC_LEXER}

genparser: ${SRC_PARSER} gendir
	bison -d -o ${CPP_PARSER} ${SRC_PARSER}

gendebugparser: ${SRC_PARSER} gendir
	bison --debug -d -o ${CPP_PARSER} ${SRC_PARSER}

gendir:
	mkdir -p ${GEN_DIR}

bindir:
	mkdir -p ${BIN_DIR}

clean:
	rm -rf ${GEN_DIR}/*
	rm -rf ${BIN_DIR}/*
