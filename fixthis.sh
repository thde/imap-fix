#!/bin/bash



check_working_directory () {
        if [[ $(echo "$PWD" | grep "mail") == "" ]]; then
                echo "Error! mot in mail directory!"
                exit 1
        fi
}

migrate_mail_directory () {
        FOLDER_OLD="$1"
        FOLDER_NEW="$2"

        if [ -d "$FOLDER_OLD" ]; then
                for FOLDER in "$(find ./ -maxdepth 1 -type d -name "$FOLDER_OLD*")"; do
                        FOLDER_BASE="$(basename "$FOLDER")"
                        TARGET_BASE="${FOLDER_BASE//$FOLDER_OLD/$FOLDER_NEW}"

                        rsync -rpav "$FOLDER_BASE" "${TARGET_BASE//$FOLDER_OLD/$FOLDER_NEW}"
                        rm -rf "$FOLDER_BASE"
                done
        fi
}

check_working_directory

migrate_mail_directory ".Gesendete Objekte" ".Sent"
migrate_mail_directory ".Gesendete Elemente" ".Sent"
migrate_mail_directory ".Entw&APw-rfe" ".Drafts"
migrate_mail_directory ".Papierkorb" ".Trash"
migrate_mail_directory ".Spam" ".Junk"
