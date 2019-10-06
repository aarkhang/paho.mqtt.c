#*******************************************************************************
#  Copyright (c) 2015, 2017 logi.cals GmbH and others
#
#  All rights reserved. This program and the accompanying materials
#  are made available under the terms of the Eclipse Public License v1.0
#  and Eclipse Distribution License v1.0 which accompany this distribution.
#
#  The Eclipse Public License is available at
#     http://www.eclipse.org/legal/epl-v10.html
#  and the Eclipse Distribution License is available at
#    http://www.eclipse.org/org/documents/edl-v10.php.
#
#  Contributors:
#     Rainer Poisel - initial version
#     Ian Craggs - update sample names
#*******************************************************************************/

# Note: on OS X you should install XCode and the associated command-line tools

## compilation/linkage settings
INCLUDE_DIRECTORIES(
    .
    ${PROJECT_SOURCE_DIR}/src
    ${PROJECT_BINARY_DIR}
    )

IF (WIN32)
  	ADD_DEFINITIONS(/DCMAKE_BUILD /D_CRT_SECURE_NO_DEPRECATE)
ENDIF()

# sample files c
ADD_EXECUTABLE(paho_c_pub paho_c_pub.c pubsub_opts.c)
ADD_EXECUTABLE(paho_c_sub paho_c_sub.c pubsub_opts.c)

if (PAHO_BUILD_STATIC)
  if (PAHO_WITH_SSL)
	set(MQTT3A_LIB paho-mqtt3as-static )
	set(MQTT3C_LIB paho-mqtt3cs-static )
  else()
	set(MQTT3A_LIB paho-mqtt3a-static )
	set(MQTT3C_LIB paho-mqtt3c-static )
  endif()
else()
  if (PAHO_WITH_SSL)
	set(MQTT3A_LIB paho-mqtt3as )
	set(MQTT3C_LIB paho-mqtt3cs )
  else()
	set(MQTT3A_LIB paho-mqtt3a )
	set(MQTT3C_LIB paho-mqtt3c )
  endif()
endif()

TARGET_LINK_LIBRARIES(paho_c_pub ${MQTT3A_LIB})
TARGET_LINK_LIBRARIES(paho_c_sub ${MQTT3A_LIB})

if (PAHO_WITH_SSL)
ADD_EXECUTABLE(paho_cs_pub paho_cs_pub.c pubsub_opts.c)
ADD_EXECUTABLE(paho_cs_sub paho_cs_sub.c pubsub_opts.c)

TARGET_LINK_LIBRARIES(paho_cs_pub ${MQTT3C_LIB})
TARGET_LINK_LIBRARIES(paho_cs_sub ${MQTT3C_LIB})
endif()


ADD_EXECUTABLE(MQTTAsync_subscribe MQTTAsync_subscribe.c)
ADD_EXECUTABLE(MQTTAsync_publish MQTTAsync_publish.c)
ADD_EXECUTABLE(MQTTClient_subscribe MQTTClient_subscribe.c)
ADD_EXECUTABLE(MQTTClient_publish MQTTClient_publish.c)
ADD_EXECUTABLE(MQTTClient_publish_async MQTTClient_publish_async.c)

TARGET_LINK_LIBRARIES(MQTTAsync_subscribe ${MQTT3A_LIB})
TARGET_LINK_LIBRARIES(MQTTAsync_publish ${MQTT3A_LIB})
TARGET_LINK_LIBRARIES(MQTTClient_subscribe ${MQTT3C_LIB})
TARGET_LINK_LIBRARIES(MQTTClient_publish ${MQTT3C_LIB})
TARGET_LINK_LIBRARIES(MQTTClient_publish_async ${MQTT3C_LIB})

INSTALL(TARGETS paho_c_sub
                paho_c_pub
                MQTTAsync_subscribe
                MQTTAsync_publish
                MQTTClient_subscribe
                MQTTClient_publish
                MQTTClient_publish_async

    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR})

if (PAHO_WITH_SSL)
INSTALL(TARGETS paho_cs_sub
                paho_cs_pub

    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR})
endif()
