
rm -f news/cmd/*log
rm -f comment/cmd/*log
cd "e:\Go\skilfactory\module40\final\apigw\cmd\"
rm -f *.log
cd "e:\Go\skilfactory\module40\final\news\cmd\"
rm -f *.log
start /d "e:\Go\skilfactory\module40\final\news\cmd\" newscmd.exe -debug
cd "e:\Go\skilfactory\module40\final\comment\cmd\"
rm -f *.log
start /d "e:\Go\skilfactory\module40\final\comment\cmd\" comcmd.exe -debug