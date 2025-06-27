#!/bin/bash

POSTGRES_USER=$1

pg_isready -U "${POSTGRES_USER}"

