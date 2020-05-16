call mvnw clean install ^
            -DMAVEN_OPTS=-Xmx1024m ^
            -Dmaven.test.skip=true ^
            -Dcontext=/codenjoy-contest ^
            -Dspring.profiles.active=sqlite,debug ^
            -Dserver.port=8080 ^
            -Dadmin.login=admin@codenjoyme.com ^
            -Dadmin.password=admin ^
            -DallGames
rem			-Psnake,bomberman,sample
