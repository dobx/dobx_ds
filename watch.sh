#!/bin/sh

TARGET=watch

[ "$1" = "0" ] && TARGET=build

dart tool/$TARGET.dart
