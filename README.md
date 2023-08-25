# 自动化部署脚本

> shell 脚本环境下运行


1. 填写 `./build.sh` 中以下内容
   ```bash
    ip="192.168.0.155" # 服务器地址
    user="root" # sudo 用户组人员
    Dir="laison-flowform-doc" # 部署目录
    testDir="test-laison-flowform-doc" # 测试部署目录
    dist="./docs/.vuepress/dist" # 指定dist 目录
    ```
2. 在服务器 `/usr/local/` 路径下创建 (Dir,testDir) 对应目录 ,如果没有创建，会自动创建 
3. nginx 服务器需要配置  serve  对应的地址
4. 执行脚本 ./build.sh


