#!/usr/bin/bash

strip_string() {
    local s="$1"
    s="${s#labs/lab}"
    s="${s%.yml}"
    echo "$s"
}
if [[ $# -eq 2 ]]; then
    ansible-playbook -i inventory/inventory.yml -e lab_id="$1" "$2"
elif [[ $# -eq 1 ]]; then
    ansible-playbook -i inventory/inventory.yml site.yml -e lab_id="$1"
else
    for lab in labs/*.yml; do
        echo "Now Deploying $(strip_string "$lab")"
        ansible-playbook -i inventory/inventory.yml site.yml -e lab_id="$(strip_string "$lab")"
    done
fi