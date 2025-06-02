#!/bin/sh

DIR="$(pwd)"
rm -rf "$DIR/contrib"
mkdir "$DIR/contrib"

git clone https://github.com/jqlang/jq /tmp/jq-src
cp -a jq-docs-root/* /tmp/jq-src/docs
cd /tmp/jq-src/docs

mkdir output
./build_website.py
cp output/manual/index.html docset/jq.html

gm convert \
    public/icon.png \
    -thumbnail '16x16>' \
    -background transparent \
    -gravity center \
    -extent 16x16 \
    "docset/icon.png"

gm convert \
    public/icon.png \
    -thumbnail '32x32>' \
    -background transparent \
    -gravity center \
    -extent 32x32 \
    "docset/icon@2x.png"

cd docset
dashing build
cp -a jq.docset "$DIR"
tar --exclude='.DS_Store' -cvzf "$DIR/contrib/jq.tgz" jq.docset
JQ_TGZ_MD5SUM=$(md5sum "$DIR/contrib/jq.tgz" | sed -E 's/^(\w+).*/\1/')
cd ..

JQ_TGZ_MD5SUM=$JQ_TGZ_MD5SUM jq -n '
{
    "name": "jq",
    "version": "dev/\(env.JQ_TGZ_MD5SUM)",
    "archive": "jq.tgz",
    "author": {
        "name": "Mattias Wadman",
        "link": "https://github.com/wader/jq-dash-docset"
    },
}' > "$DIR/contrib/docset.json"

