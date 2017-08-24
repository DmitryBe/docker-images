#!/bin/bash

render_template() {
  eval "echo \"$(cat $1)\""
}

echo 'app dir: ' $APP_DIR

# if PORT0 -> SSDB_PORT
if [[ -z ${PORT0} ]]; 
	then 
		echo 'PORT0 was not provided'; 
		if [[ -z ${SSDB_PORT} ]]; then SSDB_PORT=8888; else echo ''; fi
		echo 'SSDB_PORT: ' ${SSDB_PORT}
	else 
		SSDB_PORT=${PORT0}; 
		echo 'SSDB_PORT <- PORT0: ' $SSDB_PORT
fi

# render config (replace env var)
render_template ${APP_DIR}/config/ssdb.conf.template  > ${APP_DIR}/config/ssdb.conf

${APP_DIR}/ssdb-server ${APP_DIR}/config/ssdb.conf
