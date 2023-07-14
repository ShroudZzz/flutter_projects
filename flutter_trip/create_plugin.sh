#!/bin/bash

# Function to create Flutter plugin
create_flutter_plugin() {
    PLUGIN_NAME=$1
    PLUGIN_PATH=~/my_plugins/$PLUGIN_NAME

    # Create directory if it does not exist
    mkdir -p $PLUGIN_PATH

    # Go to the directory
    cd $PLUGIN_PATH

    # Create Flutter plugin
    flutter create --template=plugin $PLUGIN_NAME
}

# Call the function with plugin name as parameter
create_flutter_plugin $1

# check package valid before publish package
# flutter packages pub publish --dry-run