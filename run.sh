#!/bin/bash
set -evx

REPO="https://${BOTTOKEN}@github.com/hisili/P8702N.git"
ASSETS="https://uploads.github.com/repos/hisili/P8702N/releases"
RECREAT="https://api.github.com/repos/hisili/P8702N/releases"
RELEASE="https://api.github.com/repos/hisili/P8702N/releases/latest"
DL="https://doc-08-2o-docs.googleusercontent.com/docs/securesc/ha0ro937gcuc7l7deffksulhg5h7mbp1/v9p7e08peorvu9be7m3qboclm9tg945v/1573848000000/16243464684326191822/*/0B-U-Krbg5qbTZG43M0J3Q3JJOEE?e=download"

upload_file() {
    curl --fail -H "Authorization: token ${BOTTOKEN}" -H "Content-Type: $(file -b --mime-type $1)" --data-binary @$1 "${ASSETS}/${2}/assets?name=$(basename $1)"
}

#curl -u jtanx:${BOTTOKEN} --fail https://api.github.com/user >/dev/null

git config --global user.email "hisi-bot@hisili"
git config --global user.name "bot"

curl -LJO "$DL"
tar axf *.gz

ls -lR
cat consumer_install
./tmp.sh
ls -l
cd 100AAJX8
export BASH=$(which bash)
echo $BASH
sudo rm /bin/sh
sudo ln -s /bin/bash /bin/sh
bash --version
make PROFILE=DSL-2492GNAU-B3BC -j4


exit

mkdir tmp
pushd tmp

tar axf ../100AAJX8_4.16L.02A_consumer.tar.gz

git init
git add .
git commit -m "init" --quiet
git tag -a "1.0.0" -m "1.0.0"
git remote add origin "$REPO" > /dev/null 2>&1
git push --tags --quiet --set-upstream origin master 
popd


exit

#curl --fail -H "Authorization: token ${BOTTOKEN}" -H "Content-Type: application/json" --data '{"tag_name":"1.0.0", "name":"1.0.0", "body":"'"$DL"'}' "$RECREAT"

relid=$(curl -s "$RELEASE" | python3 -c "import sys,json; print(json.load(sys.stdin)['id'])")

pushd E5770s-923_open_src
for f in *; do
    tar acf "$f.tar.xz" "$f"
    upload_file "$f.tar.xz" "$relid"
done
popd

upload_file E5770s-923_open_src.rar "$relid"
