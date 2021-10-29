#!/bin/bash

setvar() {
  var=MLS_$1
  val=${!var:-$2}
  export $var="$val"
}

# Default base value
setvar TAG                        "latest"
setvar CONFIG                     "./config"

# Tags for the docker images
setvar GATEWAY_TAG                "${MLS_TAG}"
setvar AUTH_TAG                   "${MLS_TAG}"
setvar COCESO_TAG                 "${MLS_TAG}"
setvar FRONTEND_TAG               "${MLS_TAG}"
setvar AMQP_TAG                   "${MLS_TAG}"
setvar DB_TAG                     "${MLS_TAG}"

setvar GEOCODING_TAG              "${MLS_TAG}"
setvar GEOCODING_POI_TAG          "${MLS_GEOCODING_TAG}"
setvar GEOCODING_VIENNA_TAG       "${MLS_GEOCODING_TAG}"
setvar GEOCODING_GMAPS_TAG        "${MLS_GEOCODING_TAG}"
setvar GEOCODING_INTERSECTION_TAG "${MLS_GEOCODING_GMAPS_TAG}"

setvar MESSAGE_TAG                "${MLS_TAG}"
setvar MESSAGE_FLEETSYNC_TAG      "${MLS_MESSAGE_TAG}"
setvar MESSAGE_SMS_TAG            "${MLS_MESSAGE_TAG}"
setvar MESSAGE_TETRA_TAG          "${MLS_MESSAGE_TAG}"
setvar MESSAGE_MOCK_GATEWAY_TAG   "${MLS_MESSAGE_TAG}"

# Config directories to use
setvar GATEWAY_CONFIG                 "${MLS_CONFIG}/gateway"
setvar AUTH_CONFIG                    "${MLS_CONFIG}/auth"
setvar COCESO_CONFIG                  "${MLS_CONFIG}/coceso"

setvar GEOCODING_POI_CONFIG           "${MLS_CONFIG}/geocoding-poi"
setvar GEOCODING_VIENNA_CONFIG        "${MLS_CONFIG}/geocoding-vienna"
setvar GEOCODING_GMAPS_CONFIG         "${MLS_CONFIG}/geocoding-gmaps"
setvar GEOCODING_INTERSECTION_CONFIG  "${MLS_GEOCODING_GMAPS_CONFIG}"

setvar MESSAGE_FLEETSYNC_CONFIG       "${MLS_CONFIG}/message-fleetsync"
setvar MESSAGE_SMS_CONFIG             "${MLS_CONFIG}/message-sms"
setvar MESSAGE_TETRA_CONFIG           "${MLS_CONFIG}/message-tetra"

# Execute the passed command with the new environment variables
"$@"
