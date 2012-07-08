# RB_DNS

### What's this?

A custom dig-like DNS tool to avoid DNS pollution.

### How to use?

- Put the `udp_server.rb` on a server where the upstream DNS server you can trust.
- Make sure port 9901 is open and run the server.
- On the client side, use `udp_client` to send queries.

### Example

```
$ ruby udp_client www.youtube.com <your-server-address>
```