#!/usr/bin/awk -f
# ip2dec
BEGIN {
    ip = ARGV[1]
    split(ip, octets, ".")
    for (i = 1; i <= 4; i++) {
        dec += octets[i] * 256 ** (4 - i)
    }
    printf("%i\n", dec)
}
