#!/bin/bash
set -ev

REPO="https://${BOTTOKEN}@github.com/hisili/E5573Cs.git"
ASSETS="https://uploads.github.com/repos/hisili/E5573Cs/releases"
RECREAT="https://api.github.com/repos/hisili/E5573Cs/releases"
RELEASE="https://api.github.com/repos/hisili/E5573Cs/releases/latest"
DL="http://download-c1.huawei.com/download/downloadCenter?downloadId=98349&version=414501&siteCode=worldwide"

upload_file() {
    curl --fail -H "Authorization: token ${BOTTOKEN}" -H "Content-Type: $(file -b --mime-type $1)" --data-binary @$1 "${ASSETS}/${2}/assets?name=$(basename $1)"
}

curl -u jtanx:${BOTTOKEN} --fail https://api.github.com/user >/dev/null

git config --global user.email "hisi-bot@hisili"
git config --global user.name "bot"

curl -Lo unrar "https://github.com/hisili/hisi_upload/releases/download/v0/unrar-nonfree" && chmod +x unrar

curl -LOJ "$DL"

./unrar x -id *.rar >/dev/null
mv E5573Cs-609_open_src/E5573Cs-609_open_src/* E5573Cs-609_open_src/
rm -r E5573Cs-609_open_src/E5573Cs-609_open_src

#tar axf E5573Cs-609_open_src/*kernel*.gz
#pushd kernel
#git init
#git add .
#git commit -m "init" --quiet
#git tag -a "1.0.0" -m "1.0.0"
#git remote add origin "$REPO" > /dev/null 2>&1
#git push --tags --quiet --set-upstream origin master 
#popd

rm E5573Cs-609_open_src/*kernel*.gz
rm E5573Cs-609_open_src/*.pdf

#curl --fail -H "Authorization: token ${BOTTOKEN}" -H "Content-Type: application/json" --data '{"tag_name":"1.0.0", "name":"1.0.0", "body":"'"$DL"'}' "$RECREAT"

relid=$(curl -s "$RELEASE" | python3 -c "import sys,json; print(json.load(sys.stdin)['id'])")

pushd E5573Cs-609_open_src
for f in *; do
    tar acf "$f.tar.xz" "$f"
    upload_file "$f.tar.xz" "$relid"
done
popd

upload_file E5573Cs-609_open_src.rar "$relid"
