#!/bin/bash

sudo docker ps --format "{{.Names}}\t{{.Ports}}"

sudo docker stats --format "table {{.Name}}\t{{.CPUPerc}}\t{{.MemPerc}}"
