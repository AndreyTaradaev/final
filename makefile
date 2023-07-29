# windows
BINARY_NAME_GW=apicmd.exe
BINARY_NAME_NEWS=newscmd.exe
BINARY_NAME_COMMENT=comcmd.exe
BINARY_DIR=./bin
SOURCE_GATE=./apigw/cmd/
SOURCE_NEWS=./news/cmd/
SOURCE_COMMENT=./comment/cmd/
gate:  ${SOURCE_GATE}main.go
	 
	go build  -o ${SOURCE_GATE}/${BINARY_NAME_GW}  ${SOURCE_GATE}
	

news:  ${SOURCE_NEWS}newscmd.go
	
	go build  -o ${SOURCE_NEWS}/${BINARY_NAME_NEWS}  ${SOURCE_NEWS}
	
	
comment:  ${SOURCE_COMMENT}comcmd.go
	
	go build  -o ${SOURCE_COMMENT}/${BINARY_NAME_COMMENT}  ${SOURCE_COMMENT}
		
build: 	gate news comment

install: ${SOURCE_GATE}/${BINARY_NAME_GW}  ${SOURCE_NEWS}/${BINARY_NAME_NEWS}  ${SOURCE_COMMENT}/${BINARY_NAME_COMMENT}
	mkdir -p ${BINARY_DIR}/gw/
	mkdir -p ${BINARY_DIR}/news/ 
	mkdir -p ${BINARY_DIR}/comment/ 
	cp ${SOURCE_GATE}config.json ./${BINARY_DIR}/gw
	cp ${SOURCE_NEWS}config.json ./${BINARY_DIR}/news
	cp ${SOURCE_COMMENT}config.json ./${BINARY_DIR}/comment
	cp ${SOURCE_GATE}/${BINARY_NAME_GW}   ./${BINARY_DIR}/gw/
	cp ${SOURCE_NEWS}/${BINARY_NAME_NEWS} ./${BINARY_DIR}/news/
	cp ${SOURCE_COMMENT}/${BINARY_NAME_COMMENT} ./${BINARY_DIR}/comment/
	
#run:	install
#	@-./${BINARY_DIR}/comment/comcmd.exe
#	./${BINARY_DIR}/news/newscmd.exe
#	./${BINARY_DIR}/gw/apicmd.exe
	
#debug: install	
#	start /d .\${BINARY_DIR}\comment  comcmd.exe -debug
#	start /d  ./${BINARY_DIR}/news  newscmd.exe -debug
#	start /d   ./${BINARY_DIR}/gw  apicmd.exe -debug

uninstall: 
	rm -f ${BINARY_DIR}/gw/*
	rm -f ${BINARY_DIR}/news/*
	rm -f ${BINARY_DIR}/comment/* 
	