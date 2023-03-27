cmake_minimum_required(VERSION 3.20)
project(Assignment_3_Parser)

set(CMAKE_CXX_STANDARD 98)


ADD_CUSTOM_COMMAND(
        OUTPUT ../Parser.cpp ../Parser.hpp
        COMMAND bison -d -o../Parser.cpp ../CMinus.y
        DEPENDS CMinus.l CMinus.y
        COMMENT "Generating Parser.cpp and Parser.h"
)

ADD_CUSTOM_COMMAND(
        COMMENT "Generating Scanner.cpp"
        SOURCE CMinus.l
        OUTPUT ../Scanner.cpp
        COMMAND flex -o../Scanner.cpp ../CMinus.l
        DEPENDS CMinus.l
)


add_executable(Assignment_3_Parser main.cpp Scanner.cpp Parser.cpp treenode.cpp Variable.cpp Variable.h Function.cpp Function.h FunctionTable.cpp FunctionTable.h VariableTable.cpp VariableTable.h CodeGenerator.cpp CodeGenerator.h backfillLine.cpp backfillLine.h)
