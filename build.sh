#!/bin/bash

helm package pso-explorer/
helm repo index .
