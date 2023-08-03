#!/bin/sh
echo "Run news microservice" 
/opt/news/newscmd -d   > /opt/logs/news.log &   
echo "Run comment microservice" 
/opt/comment/commentcmd -d    > /opt/logs/comment.log & 
echo "Run censor microservice" 
/opt/censor/censorcmd -d  > /opt/logs/censor.log &
echo "Run gateway microservice" 
cd  /opt/gw/ 
/opt/gw/gwcmd -d
