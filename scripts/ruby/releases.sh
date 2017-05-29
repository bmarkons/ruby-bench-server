#!/bin/bash

exec &>> $HOME/logs/ruby/releases/run.log

echo --------------$(date)

RUBY_BENCHMARKS=$1
RUBY_MEMORY_BENCHMARKS=$2
OPTCARROT_BENCHMARK=$3
LIQUID_BENCHMARK=$4
RUBY_VERSION=$5
API_NAME=$6
API_PASSWORD=$7
PATTERNS=$8

docker pull rubybench/ruby_releases

docker run --rm \
  -e "RUBY_BENCHMARKS=$RUBY_BENCHMARKS" \
  -e "RUBY_MEMORY_BENCHMARKS=$RUBY_MEMORY_BENCHMARKS" \
  -e "OPTCARROT_BENCHMARK=$OPTCARROT_BENCHMARK" \
  -e "LIQUID_BENCHMARK=$LIQUID_BENCHMARK" \
  -e "RUBY_VERSION=$RUBY_VERSION" \
  -e "API_NAME=$API_NAME" \
  -e "API_PASSWORD=$API_PASSWORD" \
  -e "INCLUDE_PATTERNS=$PATTERNS" \
  rubybench/ruby_releases
