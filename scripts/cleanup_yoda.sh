#!/bin/bash

find /etc/yoda/* -maxdepth 0 -mmin +240 -exec rm -rf {} \;
