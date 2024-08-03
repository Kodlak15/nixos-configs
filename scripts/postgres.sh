#!/usr/bin/env bash

# Docker DB
DOCKER_DB_NAME="postgres"
DOCKER_DB_USER="postgres"
DOCKER_DB_PASSWORD="example"
DOCKER_DB_HOST="0.0.0.0"
DOCKER_DB_PORT="5432"
DOCKER_DB_SSL_MODE="disable"

# Test DB
TEST_DB_NAME="postgres"
TEST_DB_USER="postgres"
TEST_DB_PASSWORD="example"
TEST_DB_HOST="192.168.122.214"
TEST_DB_PORT="5432"
TEST_DB_SSL_MODE="disable"

connect_docker_db() {
	psql "$DOCKER_DB_NAME://$DOCKER_DB_USER:$DOCKER_DB_PASSWORD@$DOCKER_DB_HOST:$DOCKER_DB_PORT?sslmode=$DOCKER_DB_SSL_MODE"
}

connect_test_db() {
	psql "$TEST_DB_NAME://$TEST_DB_USER:$TEST_DB_PASSWORD@$TEST_DB_HOST:$TEST_DB_PORT?sslmode=$TEST_DB_SSL_MODE"
}

help() {
	echo "Options:"
	echo "--connect-docker: Connect to the docker database with psql"
	echo "--connect-test: Connect to the test database with psql"
}

case "$1" in
"--connect-docker") connect_docker_db ;;
"--connect-test") connect_test_db ;;
*) help ;;
esac
