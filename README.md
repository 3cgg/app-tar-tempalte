
#Build
1. 修改app-env.bat/app-env.sh中的APP_MAIN_CLASS、APP_MAIN_NAME为你的java main class
2. mvn clean package -Dmaven.test.skip=true -Pprd 在target目录中生成一个tar包

#Env
1. 配置JAVA_HOME
2. jar命令可以被使用 （windows环境会使用这个命令）

#Deploy
1. 解压缩tar包
2. 修改etc目录中的相应的配置文件

##Windows
1. 修改app-env.bat文件中的 “APP_HOME” 变量指向你的运行时目录

##Linux
1. 修改app-env.sh文件中的 “APP_HOME” 变量指向你的运行时目录


Spring Boot运行的另外一种方式：https://www.jianshu.com/p/5897a567dd1b

