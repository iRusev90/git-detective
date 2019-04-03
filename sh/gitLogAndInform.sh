#!/bin/bash
thisScriptDir="$( cd "$(dirname "$0")" ; pwd -P )"
tmpGitLogFile=$thisScriptDir/../tmp/gitLog.txt

echo "" > $tmpGitLogFile
git log > $tmpGitLogFile
echo "EXPECT: git log done"
