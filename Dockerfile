FROM ubuntu:18.04

RUN apt-get update && \
    apt-get install -y snmp snmp-mibs-downloader snmpd*

RUN mkdir -p $HOME/.snmp
RUN download-mibs

RUN mv /etc/snmp/snmpd.conf /etc/snmp/snmpd.conf.backup && \
        echo "rocommunity public \nagentAddress udp:161" > /etc/snmp/snmpd.conf

EXPOSE 161/udp

CMD ["snmpd", "-f"]
