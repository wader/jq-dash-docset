#!/bin/sh

DIR="$(pwd)"
rm -rf "$DIR/contrib"
mkdir "$DIR/contrib"

git clone https://github.com/stedolan/jq /tmp/jq-src
cp -a jq-docs-root/* /tmp/jq-src/docs
cd /tmp/jq-src/docs

pipenv install
mkdir output
pipenv run ./build_docset_html.py
cd output
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
    }
}' > "$DIR/contrib/docset.json"

gm convert \
    public/jq.png \
    -thumbnail '16x16>' \
    -background transparent \
    -gravity center \
    -extent 16x16 \
    "$DIR/contrib/icon.png"

gm convert \
    public/jq.png \
    -thumbnail '32x32>' \
    -background transparent \
    -gravity center \
    -extent 32x32 \
    "$DIR/contrib/icon@2x.png"
