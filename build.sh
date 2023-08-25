#!/bin/bash
# ip="81.69.243.70"
ip="192.168.0.155"
user="root"
Dir="laison-flowform-doc"
testDir="test-laison-flowform-doc"
dist="./docs/.vuepress/dist"
# util function: print with color, usage: c_echo "Red" "Hello Man!"
c_echo() {
  # echo with color
  color=$1
  string=$2
  code=30
  case $color in
  "Red")
    code=31
    ;;
  "Green")
    code=32
    ;;
  "Orange")
    code=33
    ;;
  "Blue")
    code=34
    ;;
  "Purple")
    code=35
    ;;
  "Cyan")
    code=36
    ;;
  "LightGray")
    code=37
    ;;
  esac
  echo -e "\033[0;${code}m${string}\033[0m"
}

# handle mode input
c_echo "Black" "需要先指定打包模式('prod'|'dev'). "
c_echo "Orange" "🐮输入打包模式 : ('prod'|'dev'(回车默认选中)) : "
read -r mode
if [ "$mode" == 'dev' ] || [ -z "$mode" ]; then
  dir=${testDir}
  mode="dev"
elif [ "$mode" == 'prod' ]; then
  dir=${Dir}
else
  c_echo "Red" "🈲 无效输入!"
  exit 1
fi

c_echo "Cyan" "选中模式：${mode}"

# step 1:打包
c_echo "Blue" "1️⃣  Step 1:📢 执行打包命令!"
c_echo "Orange" "📦是否打包？ : ('yes'|'no'(回车默认选中)) : "
read -r ifBuild
if [ "$ifBuild" == 'yes' ] || [ -z "$ifBuild" ]; then
  npm run build
elif [ "$ifBuild" == 'no' ]; then
  echo "跳过打包"
else
  c_echo "Red" "🈲 无效输入!"
  exit 1
fi

c_echo "Green" "打包完成 ！"

# step 2:公钥验证
c_echo "Blue" "2️⃣  Step 2:📢 尝试建立ssh公钥验证"
# cat ~/.ssh/id_rsa.pub | ssh $user@$ip "cat - >> ~/.ssh/authorized_keys"
# 166 不接受RSA 算法密钥，需要创建 算法为 ed25519 的key pair
# ssh-keygen -t ed25519
ssh-copy-id ${user}@${ip}
c_echo "Green" "公钥验证完成 ！"

# step 3:dist目录查存
c_echo "Blue" "3️⃣  Step 3:📢 检测目标路径 dist 是否存在"
ssh ${user}@${ip} "
cd /usr/local/;
if [ ! -d ./${dir} ]; then
  echo "📢 目标路径下 ${dir} 目录不存在，尝试创建该目录"
  mkdir /usr/local/${dir}
fi;

cd /usr/local/${dir}/; 

if [ ! -d ./dist ]; then
  echo "📢 目标路径下 dist 目录不存在，尝试创建该目录"
  mkdir dist
else
  echo "📢 目标路径下 dist 目录存在"
  mv ./dist ./$(date "+dist_%Y%m%d_%H:%M:%S")
  mkdir dist
fi;
"

# step 4:上传打包文件
c_echo "Blue" "4️⃣  Step 4:📢 开始尝试上传本地打包文件至目标 dist 目录..."
echo "put -r ${dist}" | sftp ${user}@${ip}:/usr/local/${dir}/

c_echo "Green" "finished!!! 🎉🎉🎉"
