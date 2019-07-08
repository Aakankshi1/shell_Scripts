#!/bin/bash

test() {

echo "$1: This is to test trap functionality"

}

trap test 1 2 3 15
