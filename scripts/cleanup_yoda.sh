#!/bin/bash

find /etc/yoda/* -maxdepth 1 -mmin +240 -exec rm -rf {} \;
