#!/bin/bash

# Function to create Flutter package
create_flutter_package() {
    PACKAGE_NAME=$1
    PACKAGE_PATH=~/my_packages/$PACKAGE_NAME

    # Create directory if it does not exist
    mkdir -p $PACKAGE_PATH

    # Go to the directory
    cd $PACKAGE_PATH

    # Create Flutter package
    flutter create --template=package $PACKAGE_NAME
}

# Call the function with package name as parameter
create_flutter_package $1
