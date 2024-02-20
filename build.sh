set -ex

sudo rm -rf out
mkdir -p out
chmod a+rwx out
docker run -it --rm \
 -v `realpath .`:/tmp/host \
 alt:p10 \
 sh -e -x -c \
"useradd -m -U builder && \
apt-get update && \
apt-get install -y rpm-build wget \
 gcc-c++ git cmake readline-devel openssl-devel libicu-devel zlib-devel perl-podlators libcurl-devel libcares-devel libzstd-devel libunwind-devel python3 python3-module-gevent python3-module-six python3-module-yaml && \
chmod a+rwx /tmp && \
cd /home/builder && \
wget http://ftp.altlinux.ru/pub/distributions/ALTLinux/c10f1/branch/x86_64/SRPMS.classic/tarantool-2.10.3-alt1.src.rpm && \
sha256sum *.src.rpm && \
echo a27ce3e3eb5de128974692b050844be296ce32f9b177f0fdefa60236523140f3 *.src.rpm | sha256sum -c - && \
runuser -u builder -- rpm -i ./*.src.rpm && \
runuser -u builder -- rpm -ba --target x86_64 /home/builder/RPM/SPECS/*.spec && \
cp -a -v /home/builder/RPM /tmp/host/out/"
