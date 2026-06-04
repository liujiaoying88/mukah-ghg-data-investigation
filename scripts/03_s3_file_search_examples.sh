#!/bin/bash

# Example commands used during investigation

# List all files

aws s3 ls s3://ec-mukahead-ghg/

# Search files from a specific date

aws s3 ls s3://ec-mukahead-ghg/ | grep "2021-09-28"

# Search around suspected failure period

aws s3 ls s3://ec-mukahead-ghg/ | grep "2021-09-28T08"

aws s3 ls s3://ec-mukahead-ghg/ | grep "2021-09-28T09"
