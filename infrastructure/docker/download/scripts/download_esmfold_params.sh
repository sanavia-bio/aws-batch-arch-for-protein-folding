#!/bin/bash
#
# Original Copyright 2022 AlQuraishi Laboratory
# Modifications Copyright 2023 Amazon.com, Inc. or its affiliates. All Rights Reserved.
# SPDX-License-Identifier: Apache-2.0
#
# Downloads and unzips the RFDesign parameters.
#
# Usage: bash download_esmfold.sh /path/to/download/directory
set -e

if [[ $# -eq 0 ]]; then
    echo "Error: download directory must be provided as an input argument."
    exit 1
fi

if ! command -v aws &> /dev/null ; then
    echo "Error: awscli could not be found. Please install awscli."
    exit 1
fi

DOWNLOAD_DIR="$1"
ROOT_DIR="${DOWNLOAD_DIR}/esmfold_params/hub/checkpoints"
SOURCE_URL="s3://aws-batch-architecture-for-alphafold-public-artifacts/compressed/esmfold_parameters_221230.tar"
BASENAME=$(basename "${SOURCE_URL}")

mkdir -p "${ROOT_DIR}"
aws s3 cp --no-sign-request ${SOURCE_URL} ${ROOT_DIR}
tar --extract --verbose --file="${ROOT_DIR}/${BASENAME}" \
  --directory="${ROOT_DIR}"
rm "${ROOT_DIR}/${BASENAME}"