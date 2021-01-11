# jq-dash-docset

[jq](https://stedolan.github.io/jq/) [dash](https://kapeli.com/dash) docset with no external dependencies.

# Install docset in dash

Search for "jq" under "User Contributed Docsets" in dash.

Alternatively download or clone this repo and in dash under "Docsets"
preferences tab press "+", select "Add Local Docset" and browse to where
you downloaded and select "jq.docset".

# Build docset yourself

```sh
docker build -t jqdocset - < Dockerfile && \
docker run --rm -v "$PWD:$PWD" -w "$PWD" jqdocset ./build_docset.sh
```

Now there should be a `jq.docset` directory that can be added as local docset and
a `contrib` directory with files suitable to submit as a user contributed docset.

# License

https://github.com/stedolan/jq/blob/master/COPYING
