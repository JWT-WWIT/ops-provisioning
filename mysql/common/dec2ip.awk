#!/usr/bin/awk -f
# dec2ip
# http://stackoverflow.com/questions/10768160/ip-address-converter
BEGIN {
    dec = ARGV[1]
    for (e = 3; e >= 0; e--) {
        octet = int(dec / (256 ^ e))
        dec -= octet * 256 ^ e
        ip = ip delim octet
        delim = "."
    }
    printf("%s\n", ip)
}
