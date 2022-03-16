SUBJECT="client.alpha.tech.local"


#client certificate

openssl genrsa -out $SUBJECT.key 2048

openssl req -new -sha256  \
        -config $SUBJECT.conf -extensions 'req_ext' \
        -key $SUBJECT.key \
        -out $SUBJECT.csr


openssl x509 -req -in $SUBJECT.csr \
         -CA ../rootCA.crt \
         -CAkey ../rootCA.key \
         -CAcreateserial \
         -out $SUBJECT.crt \
         -extfile $SUBJECT.conf \
         -extensions req_ext \
         -days 360 -sha256

#openssl req -in mydomain.com.csr -noout -text
#openssl x509 -in alpha.tech.local.crt -text


