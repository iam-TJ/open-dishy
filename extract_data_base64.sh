#!/usr/bin/env bash 
# Copyright 2024 Tj <hacker@iam.tj>
# Licensed on the terms of the GNU General Public Licence version 3.
# Extract and decode embeded URI data: base64 encodings to files

TMP="${TMP:-/tmp/}"

# identify line numbers 
grep -Eon 'data:[^,(<. ]*base64' dishy.starlink.com/assets/app.bundle.web.2023_mod.js | while IFS=: read -r line d dt; do
 echo "$line $dt"
 dt="${dt%;*}"
 # extract each line containing data:base64 blocks
 sed -n "$line,$line p" dishy.starlink.com/assets/app.bundle.web.2023_mod.js > "${TMP}line_${line}_${dt//\//_}.base64"
done

for b in "${TMP}"line*.base64; do
 sed  "s/^.*base64,\(.*\)'.*/\1/" "$b" > "$b.b64"
done

mkdir -p ./data
for b in "${TMP}"*.b64; do
 echo "$b"
 [[ "$b" =~ .*line_.*_([^.]*)\.base64.* ]]
 t="${BASH_REMATCH[1]}"
 base64 -d "$b" > "./data/${b//${TMP}}.${t}"
done

rm "${TMP}"*.base64 "${TMP}"*.b64

ls -latr ./data
