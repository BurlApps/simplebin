#!/bin/bash

forever stopall
forever start -c coffee start.coffee
