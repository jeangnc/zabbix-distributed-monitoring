FROM ubuntu:18.04

RUN apt-get update && \
    apt-get install -y snmp snmp-mibs-downloader snmpd*

RUN mv /etc/snmp/snmpd.conf /etc/snmp/snmpd.conf.backup && \
        echo "rocommunity public \nagentAddress udp:161" > /etc/snmp/snmpd.conf

RUN download-mibs
RUN sed -i 's/mibs :/# mibs :/g' /etc/snmp/snmp.conf

EXPOSE 161/udp

CMD ["snmpd", "-fdV"]
