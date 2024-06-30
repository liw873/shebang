#!/bin/bash

# This checks if the number of arguments is correct
# If the number of arguments is incorrect ( $# != 2) print error message and exit
if [[ $# != 2 ]]
then
  echo "backup.sh target_directory_name destination_directory_name"
  exit
fi

# This checks if argument 1 and argument 2 are valid directory paths
if [[ ! -d $1 ]] || [[ ! -d $2 ]]
then
  echo "Invalid directory path provided"
  exit
fi

# [TASK 1]
targetDirectory=$1
destinationDirectory=$2

# [TASK 2]
echo "Target Directory: $targetDirectory"
echo "Destination Directory: $destinationDirectory"

# [TASK 3]
currentTS=$(date +"%Y-%m-%d_%H-%M-%S")

# [TASK 4]
backupFileName="backup-$currentTS.tar.gz"

# We're going to:
  # 1: Go into the target directory
  # 2: Create the backup file
  # 3: Move the backup file to the destination directory

# To make things easier, we will define some useful variables...

# [TASK 5]
origAbsPath=$(pwd)

# [TASK 6]
cd $destinationDirectory
destDirAbsPath=$(pwd)

# [TASK 7]
cd $origAbsPath
cd $targetDirectory

# [TASK 8]
yesterdayTS=$(date -d "yesterday" +"%Y-%m-%d %H:%M:%S")

declare -a toBackup

for file in $(ls)
do
  if [[ $(stat -c %y "$file") > $yesterdayTS ]]
  then
    toBackup+=($file)
  fi
done

if [ ${#toBackup[@]} -eq 0 ]
then
  echo "No files to backup."
  exit 0
fi


tar -czf $backupFileName ${toBackup[@]}
mv $backupFileName $destDirAbsPath

echo "Backup completed successfully: $destDirAbsPath/$backupFileName"


# Congratulations! You completed the final project for this course!
