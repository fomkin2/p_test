#!/bin/sh
if [ "$PULL_REQUEST" = false ] && [ "$BRANCH" = "develop" ] || [ "$BRANCH" = "master" ]
then

  eval `ssh-agent -s`
  ssh-add /home/shippable/.ssh/project_rsa

  if [ "$BRANCH" = "develop" ]
  then
    cap staging deploy
  elif [ "$BRANCH" = "master" ]
  then
    cap production deploy
  fi

else

  echo 'no deploy needs'

fi
