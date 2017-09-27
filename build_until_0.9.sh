#!/usr/bin/env bash

set -x

CWD=$(pwd)
BUILD_PATH="$(pwd)/build"
TERRAFORM_PATH="$(pwd)/terraform"

mkdir $BUILD_PATH

git clone https://github.com/hashicorp/terraform.git $TERRAFORM_PATH || true

bundle install

make_docs() {
    tag=$1

    tag_dir="$BUILD_PATH/$tag"

    rm -rf $tag_dir
    mkdir $tag_dir

    cd $TERRAFORM_PATH
    git reset --hard
    git checkout $tag

    cp $CWD/Rakefile $TERRAFORM_PATH/website

    cd $TERRAFORM_PATH/website

    bundle update
    bundle install

    rake

    if [ $? -eq 0 ]; then
        mv Terraform.tgz $tag_dir
    else
        rm -rf $tag_dir
    fi
}

cd $TERRAFORM_PATH

for tag in `git tag | fgrep -v - | fgrep v`; do
    minor_version=`echo $tag | cut -d"." -f2`
    if [ $minor_version -gt 9 ]; then
        echo "This generator supports Terraform <= 0.9.11 only. Use XXX for >= 0.10.0"
    else
        make_docs $tag
    fi
done

cd $CWD
