#!/bin/bash

# Define variables for certificate details
COMMON_NAME="cluster-example"
DAYS_VALID=365
OUTPUT_DIR="./certs"
CERT_FILE="$OUTPUT_DIR/server.crt"
KEY_FILE="$OUTPUT_DIR/server.key"

# Create output directory if it doesn't exist
mkdir -p "$OUTPUT_DIR"
rm -f ${OUTPUT_DIR}/server.crt
rm -f ${OUTPUT_DIR}/server.key
rm -f ${OUTPUT_DIR}/server.csr

ls $OUTPUT_DIR

# Generate private key
openssl genrsa -out "$KEY_FILE" 2048

# Generate CSR (Certificate Signing Request)
openssl req -new -key "$KEY_FILE" -out "$OUTPUT_DIR/server.csr" -subj "/CN=$COMMON_NAME"

# Generate self-signed certificate
openssl x509 -req -days "$DAYS_VALID" -in "$OUTPUT_DIR/server.csr" -signkey "$KEY_FILE" -out "$CERT_FILE"

echo "Self-signed certificate generated:"
echo "Certificate file: $CERT_FILE"
echo "Private key file: $KEY_FILE"

