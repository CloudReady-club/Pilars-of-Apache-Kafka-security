COMMON_NAME=$1
PASSWORD=$2
ORGANIZATIONAL_UNIT="IT"
ORGANIZATION="Digital Infornation Inc CA Root Authority"
CITY="Montreal"
STATE="QC"
COUNTRY="CA"

CA_ALIAS="ca-root"
CA_CERT_FILE="rootCa.crt" 
CA_KEY_FILE="rootCa.key" 

VALIDITY_DAYS=365

# Generate Keystore with Private Key
keytool -keystore keystore/$COMMON_NAME.keystore.jks \
            -alias $COMMON_NAME -validity $VALIDITY_DAYS \
            -genkey -keyalg RSA \
            -storepass $PASSWORD \
            -dname "CN=$COMMON_NAME, OU=$ORGANIZATIONAL_UNIT, O=$ORGANIZATION, L=$CITY, ST=$STATE, C=$COUNTRY"

# Generate Certificate Signing Request (CSR) using the newly created KeyStore
keytool -keystore keystore/$COMMON_NAME.keystore.jks \
         -storepass $PASSWORD \
         -alias $COMMON_NAME -certreq -file $COMMON_NAME.csr 

# Sign the CSR using the custom CA
openssl x509 -req -CA $CA_CERT_FILE -CAkey $CA_KEY_FILE \
         -in $COMMON_NAME.csr -out $COMMON_NAME.signed \
         -days $VALIDITY_DAYS -CAcreateserial

# Import ROOT CA certificate into Keystore
keytool -keystore keystore/$COMMON_NAME.keystore.jks \
    -storepass $PASSWORD \
    -alias $CA_ALIAS -importcert -file $CA_CERT_FILE

# Import newly signed certificate into Keystore
keytool -keystore keystore/$COMMON_NAME.keystore.jks \
    -storepass $PASSWORD \
    -alias $COMMON_NAME -importcert -file $COMMON_NAME.signed

# Clean-up 
rm $COMMON_NAME.csr
rm $COMMON_NAME.signed
rm rootCa.srl