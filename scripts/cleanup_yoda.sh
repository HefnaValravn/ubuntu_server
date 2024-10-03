#!/bin/bash

find /etc/yoda/* -maxdepth 1 -mmin +58 -exec rm -rf {} \;
