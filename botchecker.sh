#!/bin/bash
LAST_TIMESTAMP=$(cat release-dir/last_time.log)
NEW_TIMESTAMP=$(sudo stat -c %Y release-dir/)

if [ "$NEW_TIMESTAMP" == "$LAST_TIMESTAMP" ]; then
  echo "nothing new"
  exit 0
else
    curl -k -X POST https://localhost.localdomain/api/v1/messages \
    -u eg-releases-bot@localhost.localdomain:yoW1tydI5ym5ulv62cUb3IOCwwnD07mc \
    -d "type=stream" \
    -d "to=test_group" \
    -d "subject=NEW RELEASE ARRIVE" \
    -d "content=NEW RELEASE!!!!!!!!!!!!!!!WOW"

  echo $NEW_TIMESTAMP >release-dir/last_time.log
fi
