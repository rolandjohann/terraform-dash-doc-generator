#!/usr/bin/env bash

set -x

tag=$1
if [ -z $tag ]; then
    echo '"tag" must be specified'
    exit 1
fi

CWD=$(pwd)
BUILD_PATH="$CWD/build/$tag"
TERRAFORM_PATH="$CWD/terraform-website"
CONTENT_PATH=$TERRAFORM_PATH/content

rm -rf $BUILD_PATH

git clone https://github.com/hashicorp/terraform-website.git || true
mkdir -p $BUILD_PATH

cd $TERRAFORM_PATH
make sync

cd $CONTENT_PATH

bundle update
bundle install

cp $CWD/Rakefile .

rake

mv Terraform.docset $BUILD_PATH
