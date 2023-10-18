# jq-dash-docset

[jq](https://jqlang.github.io/jq/) [dash](https://kapeli.com/dash) docset.

# Install docset in dash

Search for "jq" under "User Contributed Docsets" in dash.

Alternatively download or clone this repo and in dash under "Docsets"
preferences tab press "+", select "Add Local Docset" and browse to where
you downloaded and select the pre-built "jq.docset".

# Install docset in zeal

Go to https://zealusercontributions.now.sh/ and search for jq.

# Build docset yourself

```sh
docker build -t jqdocset - < Dockerfile && \
docker run --rm -v "$PWD:$PWD" -w "$PWD" jqdocset ./build_docset.sh
```

Now there should be a `jq.docset` directory that can be added as local docset and
a `contrib` directory with files suitable to submit as a user contributed docset.

# Thanks and license

Documentation and generated HTML is based on jq's own documentation system.

https://github.com/jqlang/jq/blob/master/COPYING
