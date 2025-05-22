#!/bin/bash
curl -s http://localhost | grep -q "Welcome" || exit 1

