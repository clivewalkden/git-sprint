#!/bin/bash

usage() {
    echo "Usage: [environment] gitsprint-installer.sh [install|uninstall] [stable|development|version] [tag]"
    echo "Environment:"
    echo "    PREFIX=$PREFIX"
    echo "    REPO_HOME=$REPO_HOME"
    echo "    REPO_NAME=$REPO_NAME"
    exit 1
}

# Does this need to be smarter for each host OS?
if [ -z "$PREFIX" ] ; then
	PREFIX="/usr/local"
fi

if [ -z "$REPO_NAME" ] ; then
	REPO_NAME="gitsprint"
fi

if [ -z "$REPO_HOME" ] ; then
	REPO_HOME="https://github.com/clivewalkden/git-sprint.git"
fi

EXEC_PREFIX="$PREFIX"
BINDIR="$EXEC_PREFIX/bin"
DATAROOTDIR="$PREFIX/share"
DOCDIR="$DATAROOTDIR/doc/gitsprint"

EXEC_FILES="git-sprint"
SCRIPT_FILES="git-sprint-create git-sprint-end git-sprint-version gitsprint-common"

echo "### git-sprint no-make installer ###"

case "$1" in
uninstall)
	echo "Uninstalling git-sprint from $PREFIX"
	if [ -d "$BINDIR" ] ; then
		for script_file in $SCRIPT_FILES $EXEC_FILES ; do
			echo "rm -vf $BINDIR/$script_file"
			rm -vf "$BINDIR/$script_file"
		done
		rm -rf "$DOCDIR"
	else
		echo "The '$BINDIR' directory was not found."
	fi
	exit
	;;
help)
	usage
	exit
	;;
install)
	if [ -z $2 ]; then
		usage
		exit
	fi
	echo "Installing git-sprint to $BINDIR"
	if [ -d "$REPO_NAME" -a -d "$REPO_NAME/.git" ] ; then
		echo "Using existing repo: $REPO_NAME"
	else
		echo "Cloning repo from GitHub to $REPO_NAME"
		git clone "$REPO_HOME" "$REPO_NAME"
	fi
	cd "$REPO_NAME"
	git pull
	cd "$OLDPWD"
	case "$2" in
	stable)
		cd "$REPO_NAME"
		git checkout master
		cd "$OLDPWD"
		;;
	development)
		cd "$REPO_NAME"
		git checkout development
		cd "$OLDPWD"
		;;
	version)
		cd "$REPO_NAME"
		git checkout tags/$3
		cd "$OLDPWD"
		;;		
	*)
		usage
		exit
		;;
	esac
	install -v -d -m 0755 "$PREFIX/bin"
	for exec_file in $EXEC_FILES ; do
		install -v -m 0755 "$REPO_NAME/$exec_file" "$BINDIR"
	done
	for script_file in $SCRIPT_FILES ; do
		install -v -m 0644 "$REPO_NAME/$script_file" "$BINDIR"
	done
	exit
	;;
*)
	usage
	exit
	;;
esac