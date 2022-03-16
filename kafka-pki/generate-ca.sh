
#CA Certificate
openssl genrsa  -out rootCA.key 4096

openssl req -x509 -new -nodes -key rootCA.key \
        -sha256 -days 1024 \
        -subj "/C=CA/ST=QC/L=Montreal/O=Digital Infornation Inc CA Root Authority/OU=IT" \
        -out rootCA.crt

