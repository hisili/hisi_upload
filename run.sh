#!/bin/bash
set -evx

REPO="https://${BOTTOKEN}@github.com/hisili/hisi_upload.git"
ASSETS="https://uploads.github.com/repos/hisili/hisi_upload/releases"
RECREAT="https://api.github.com/repos/hisili/hisi_upload/releases"
RELEASE="https://api.github.com/repos/hisili/hisi_upload/releases/latest"

upload_file() {
    curl --fail -H "Authorization: token ${BOTTOKEN}" -H "Content-Type: $(file -b --mime-type $1)" --data-binary @$1 "${ASSETS}/${2}/assets?name=$(basename $1)"
}

curl -u jtanx:${BOTTOKEN} --fail https://api.github.com/user >/dev/null

git config --global user.email "hisi-bot@hisili"
git config --global user.name "bot"

which split || true
which xz  || true
which hg || true
which jq || true

cat /proc/cpuinfo

relid=$(curl -s "$RELEASE" | python3 -c "import sys,json; print(json.load(sys.stdin)['id'])")
echo $relid

git clone --bare https://github.com/mozilla/gecko-dev

du -sh gecko-dev.git

XZ_OPT="-9e --threads=4" tar cJf - gecko-dev.git | split --bytes=250MB - mozilla.tar.xz.

for f in *.xz.*; do
    upload_file $f "$relid"
done


exit

#curl --fail -H "Authorization: token ${BOTTOKEN}" -H "Content-Type: application/json" --data '{"tag_name":"1.0.0", "name":"1.0.0", "body":"'"$DL"'}' "$RECREAT"

pushd E5770s-923_open_src
for f in *; do
    tar acf "$f.tar.xz" "$f"
    upload_file "$f.tar.xz" "$relid"
done
popd

upload_file E5770s-923_open_src.rar "$relid"
