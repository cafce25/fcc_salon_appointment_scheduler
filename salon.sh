#!/bin/bash
PSQL="psql -X --username=freecodecamp --dbname=salon --tuples-only -c"

SERVICE_SELECT() {
  if [[ $1 ]]; then
    echo -e "\n$1"
  fi
  #echo -e "\nWelcome to our salon! These are the services we offer:"
  # get services
  AVAILABLE_SERVICES=$($PSQL "SELECT service_id, name FROM services")
  echo "$AVAILABLE_SERVICES" | while read SERVICE_ID BAR SERVICE_NAME; do
    echo "$SERVICE_ID) $SERVICE_NAME"
  done
  #echo -e "\nPlease select one of the available services:"
  read SERVICE_ID_SELECTED
  # if not a number
  if [[ ! $SERVICE_ID_SELECTED =~ ^[0-9]+$ ]]; then
    MAIN_MENU "Please enter the number of a service."
    return
  fi
  SERVICE_NAME=$($PSQL "SELECT name FROM services WHERE service_id = $SERVICE_ID_SELECTED")
  # if not a service
  if [[ -z $SERVICE_NAME ]]; then
    MAIN_MENU "The number '$SERVICE_ID_SELECTED' is not a service we offer please select one from the list!"
    return
  fi
  echo -e "\nWhat is your phone number?"
  read CUSTOMER_PHONE
  C
}
SERVICE_SELECT
