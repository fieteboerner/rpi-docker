#!/bin/bash

if [ -z "$DOMAINS" ]; then
  echo "DOMAINS must be defined as env var"
  exit 1
elif [ "$DOMAINS" = "foo.ddns.net" ]; then
  echo "Please enter your domain in noip.conf"
  exit 1
fi

if [ -z "$LOGINNAME" ]; then
  echo "LOGINNAME must be defined as env var"
  exit 1
fi

if [ -z "$PASSWORD" ]; then
  echo "PASSWORD must be defined as env var"
  exit 1
fi

if [ -z "$INTERVAL" ]; then
  INTERVAL='30m'
fi

if [[ ! "$INTERVAL" =~ ^[0-9]+[mhd]$ ]]; then
  echo "INTERVAL must be a number followed by m, h, or d. Example: 5m"
  exit 1
fi

if [[ "${INTERVAL: -1}" == 'm' && "${INTERVAL:0:-1}" -lt 5 ]]; then
  echo "The shortest allowed INTERVAL is 5 minutes"
  exit 1
fi

USER_AGENT="docker no-ip/.1"

#-----------------------------------------------------------------------------------------------------------------------

function ts {
  echo [`date '+%b %d %X'`]
}

#-----------------------------------------------------------------------------------------------------------------------

while true
do
  RESPONSE=$(curl -S -s -k --user-agent "$USER_AGENT" -u "$LOGINNAME:$PASSWORD" "https://dynupdate.no-ip.com/nic/update?hostname=$DOMAINS" 2>&1)

  # Sometimes the API returns "nochg" without a space and ip address. It does this even if the password is incorrect.
  if [[ $RESPONSE =~ ^(good|nochg) ]]
  then
    echo "$(ts) No-IP successfully called. Result was \"$RESPONSE\"."
  elif [[ $RESPONSE =~ ^(nohost|badauth|badagent|abuse|!donator) ]]
  then
    echo "$(ts) Something went wrong. Check your settings. Result was \"$RESPONSE\"."
    echo "$(ts) For an explanation of error codes, see http://www.noip.com/integrate/response"
    exit 2
  elif [[ $RESPONSE =~ ^911 ]]
  then
    echo "$(ts) Server returned "911". Waiting for 30 minutes before trying again."
    sleep 1800
    continue
  else
    echo "$(ts) Couldn't update. Trying again in 5 minutes. Output from curl command was \"$RESPONSE\"."
  fi

  sleep $INTERVAL
done
