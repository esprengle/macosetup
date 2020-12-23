#!/usr/bin/env bash
#

# Don't run directly!
[[ "$_" == "$0" ]] && exit 255

# Example
[[ "${_example_enabled:-false}" == false ]] && return
echo "${BASH_SOURCE[0]}"

# ...