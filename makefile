# windows
BINARY_NAME_GW=apicmd.exe
BINARY_DIR=bin
SOURCE_GATE=./apigw/cmd/
SOURCE_NEWS=./news/cmd/
SOURCE_COMMENT=./comment/cmd/
gate:  ${SOURCE_GATE}main.go
	 
	go build  -o ./${SOURCE_GATE}/gw/apicmd.exe  ./apigw/cmd/
	

news:  ${SOURCE_NEWS}newscmd.go
	
	go build  -o ./${SOURCE_NEWS}/news/newscmd.exe  ./news/cmd/
	
	
comment:  ${SOURCE_COMMENT}comcmd.go
	
	go build  -o ./${SOURCE_COMMENT}/comment/comcmd.exe  ./news/cmd/
		
build: 	gate news comment

install: ./${SOURCE_GATE}/gw/apicmd.exe ./${SOURCE_NEWS}/news/newscmd.exe ./${SOURCE_COMMENT}/comment/comcmd.exe
	mkdir -p ./${BINARY_DIR}/gw/
	mkdir -p ./${BINARY_DIR}/news/ 
	mkdir -p ./${BINARY_DIR}/comment/ 
	cp ./apigw/cmd/config.json ./${BINARY_DIR}/gw
	cp ./news/cmd/config.json ./${BINARY_DIR}/news
	cp ./comment/cmd/config.json ./${BINARY_DIR}/comment
	cp ./${SOURCE_GATE}/gw/apicmd.exe ./${BINARY_DIR}/gw/
	cp ./${SOURCE_NEWS}/news/newscmd.exe ./${BINARY_DIR}/news/
	cp ./${SOURCE_COMMENT}/comment/comcmd.exe ./${BINARY_DIR}/comment/
	
#run:	install
#	@-./${BINARY_DIR}/comment/comcmd.exe
#	./${BINARY_DIR}/news/newscmd.exe
#	./${BINARY_DIR}/gw/apicmd.exe
	
#debug: install	
#	start /d .\${BINARY_DIR}\comment  comcmd.exe -debug
#	start /d  ./${BINARY_DIR}/news  newscmd.exe -debug
#	start /d   ./${BINARY_DIR}/gw  apicmd.exe -debug
	