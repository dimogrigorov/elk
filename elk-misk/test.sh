#!/bin/sh



kc_URL_Head="https://keycloak-dip.apps.openshift.sofia.ifao.net/auth/"



kc_URL_Head=$([[ $kc_URL_Head =~ .*/$ ]] && echo "$kc_URL_Head" || echo "$kc_URL_Head/")



kc_Realm="cytricNG"



KEYCLOAK_URL="${kc_URL_Head}realms/${kc_Realm}/protocol/openid-connect/token"



echo "${KEYCLOAK_URL}"
