INCLUDES:=./  ./include
SRCS:=$(wildcard ./src/*.cc) 
LIBS:=  -lwfrest -lworkflow -lssl -lcrypto -lcrypt
OBJS:=$(patsubst %.cc, %.o, $(SRCS))
SERVER:= CloudiskServer

# 目标 : 依赖
$(SERVER): ./src/main.o ./src/CloudiskServer.o ./src/Token.o ./src/Hash.o
	g++ $^ -o $@ $(LIBS) $(addprefix -I, $(INCLUDES)) -g

%.o:%.cc
	g++ -c $^ -o $@  $(addprefix -I, $(INCLUDES)) -g

HASH:=testHash
TOKEN:=testToken

$(HASH): ./src/Hash.o ./src/testHash.o
	g++ $^ -o $@ $(LIBS) $(addprefix -I, $(INCLUDES)) -g

$(TOKEN): ./src/Token.o ./src/testToken.o
	g++ $^ -o $@ $(LIBS) $(addprefix -I, $(INCLUDES)) -g

echo:
	echo $(INCLUDES)
	echo $(SRCS)

clean:
	rm -rf $(OBJS) $(SERVER) $(HASH) $(TOKEN)
