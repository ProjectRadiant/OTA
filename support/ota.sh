DEVICE=$1
ROMDIR=~/$2
MAINTAINER=$3
MAINTAINER_URL=$4
FORUM_URL=$5

# Ensures that mandatory parameters are entered
if [ $# -lt 5 ]; then
    echo "Missing mandatory parameters"
    exit 1
fi

cd $ROMDIR
DATETIME=$(grep "org.pixelexperience.build_date_utc=" out/target/product/$DEVICE/system/build.prop | cut -d "=" -f 2)
FILENAME=$(find out/target/product/$DEVICE/Nezuko*.zip | cut -d "/" -f 5)
ID=$(md5sum out/target/product/$DEVICE/Nezuko*.zip | cut -d " " -f 1)
FILEHASH=$ID
SIZE=$(wc -c out/target/product/$DEVICE/Nezuko*.zip | awk '{print $1}')
URL="https://sourceforge.net/projects/nezukoos/files/$DEVICE/$FILENAME/download"
VERSION="11"
DONATE_URL="https://nezukoos.github.io/Website/donations.html"
WEBSITE_URL="https://nezukoos.github.io/Website"
NEWS_URL="https:\/\/t.me\/NezukoOSUpdates"
JSON_FMT='{\n"error":false,\n"filename": %s,\n"datetime": %s,\n"size":%s, \n"url":"%s", \n"filehash":"%s", \n"version": "%s", \n"id": "%s",\n"donate_url": "%s",\n"website_url":"%s",\n"news_url":"%s",\n"maintainer":"%s",\n"maintainer_url":"%s",\n"forum_url":"%s"\n}'
printf "$JSON_FMT" "$FILENAME" "$DATETIME" "$SIZE" "$URL" "$FILEHASH" "$VERSION" "$ID" "$DONATE_URL" "$WEBSITE_URL" "$NEWS_URL" "$MAINTAINER" "$MAINTAINER_URL" "$FORUM_URL" > $ROMDIR/OTAbuilds/$DEVICE.json
