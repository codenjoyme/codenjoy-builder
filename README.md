Codenjoy builder
==============

Configuration
--------------
A project that brings together the Codenjoy server and several games of your choice.
You can choose which games to run with the server with command.
```
mvnw install -Pgame1,game,game3 
OR
mvnw install -DallGames
```
Be careful - run `mvnw clean` will remove sqlite database files `./target/database` so you lost your data.

Also you can change properties (please check `start-server.bat` for windows or `start-server.sh` for linux) 
```
mvnw install -DallGames -Dcontext=/any-context -Dspring.profiles.active=sqlite,postgres,debug,trace -Dserver.port=8081 -Dadmin.login=anyLogin -Dadmin.password=anyPassword
```
* `context` changes link to the application
[http://127.0.0.1:8080/codenjoy-contest](http://127.0.0.1:8080/codenjoy-contest)
* `server.port` the port on which the application starts
* `spring.profiles.active`
  * `sqlite` for the lightweight database (<50 participants)
  * `postgres` for the postgres database (>50 participants)
    * `database.host` database server host, `localhost` by default
    * `database.port` database server port, `5432` by default
    * `database.name` database name, `codenjoy` by default
    * `database.user` username to connect, `codenjoy` by default
    * `database.password` password to connect, `securePostgresDBPassword` by default
  * `trace` for enable log.debug
  * `debug` if you want to debug js files (otherwise it will compress and obfuscate)
  * `yourgame` if you added your custom configuration to the game inside `CodingDojo\games\yourgame\src\main\resources\application-yourgame.yml`

You can change any other [spring application properties](https://github.com/codenjoyme/codenjoy/tree/master/CodingDojo/server/src/main/resources) - just push it on the pom.xml
```
    <properties>
        <!-- you can change context here or on build start
             mvnv install -Dcontext=another-context
                          -Dspring.profiles.active=postgre,debug,trace
                          -Dserver.port=8081
                          -Dadmin.login=otherLogin
                          -Dadmin.password=otherPassword
        -->
        <context>/codenjoy-contest</context>
        <spring.profiles.active>sqlite,debug</spring.profiles.active>
        <server.port>8080</server.port>
        <admin.login>admin@codenjoyme.com</admin.login>
        <admin.password>admin</admin.password>
        <!-- here -->
```
and here
```
<java dir="target"
      jar="target/${context}.war"
      fork="true"
      failonerror="true"
      maxmemory="128m">

    <env key="context" value="${context}"/>
    <env key="spring.profiles.active" value="${spring.profiles.active}"/>
    <env key="server.port" value="${server.port}"/>
    <env key="admin.login" value="${admin.login}"/>
    <env key="admin.password" value="${admin.password}"/>
    <!-- and here -->
</java>
```
This is Codenjoy Maven repository. To select existing games type the following in your pom.xml file.
```
<repositories>
    <repository>
        <id>codenjoy-releases</id>
        <url>https://github.com/codenjoyme/codenjoy-repo/raw/master/snapshots</url>
    </repository>
</repositories>
```
Choose codenjoy server/engine/games version
```
<groupId>com.codenjoy</groupId>
<artifactId>codenjoy-builder</artifactId>
<!-- version for all codenjoy dependencies here -->
<version>SERVER_VERSION</version>
```
The latest version as of now
```
<properties>
    <codenjoy.version>1.1.1</codenjoy.version>
</properties>
```
If you want to add your new game - please do thing bellow. 
Add your game dependency (you can add multiple games at the same time).
```
<profiles>
    <!-- Games dependencies (put your game here - replace YOURGAME) -->
    <profile>
        <id>YOURGAME</id>
        <activation>
            <property>
                <name>allGames</name>
            </property>
        </activation>
        <dependencies>
            <dependency>
                <groupId>${project.groupId}</groupId>
                <artifactId>YOURGAME-engine</artifactId>
                <version>${project.version}</version>
            </dependency>
        </dependencies>
    </profile>
```
If you create your own game, you should have it pre-installed by running `mvnw clean install` from the game project root. If you use a game kit that already exists, you don't have to do anything - the builder will retrieve the games from the remote repository for you.

Then run
```
mvnw install -Pgame1,game,game3 -Dparameter=value ...
OR
mvnw install -DallGames -Dparameter=value ...
```

Other materials
--------------
Fore [more details, click here](https://github.com/codenjoyme/codenjoy)

[Codenjoy team](http://codenjoy.com/portal/?page_id=51)
===========