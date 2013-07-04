PACKAGE_NAME='foreman-proxy'

REPO='git://github.com/theforeman/smart-proxy.git'
if [[ "$2" == "nightly" ]] ; then
  BRANCH="develop"
else
  BRANCH='e599316efc251efa8b2cbd7edef2ffe859ef79a8'
fi

function setup_build {
  if [[ "$2" == "nightly" ]] ; then
    LAST_COMMIT=$($GIT rev-list HEAD|/usr/bin/head -n 1)

    # Add 'nightly' to changelog

    DATE=$(date -R)
    UNIXTIME=$(date +%s)
    RELEASE="9999+ubuntu1~nightlybuild${UNIXTIME}"
    MAINTAINER="Greg Sutcliffe <gsutclif@redhat.com>"

    mv debian/changelog debian/changelog.tmp

    echo "$PACKAGE_NAME ($RELEASE) UNRELEASED; urgency=low

  * Automatically built package based on the state of
    $REPO at commit $LAST_COMMIT

 -- $MAINTAINER  $DATE
" > debian/changelog

    cat debian/changelog.tmp >> debian/changelog
    rm -f debian/changelog.tmp
  else
    echo "not nightly: skipped setup_build"
  fi
}
