INSTANCE=$1
PASSWORD=$2
CA_ALIAS="rootCA"
CA_CERT_FILE="RootCA.crt" 

#### Generate Truststore and import ROOT CA certificate ####
keytool -keystore truststore/$INSTANCE.truststore.jks \
 -import -alias $CA_ALIAS -file $CA_CERT_FILE \
 -storepass $PASSWORD
