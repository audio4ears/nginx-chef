# nginx-chef

This cookbook installs [NGINX](https://www.nginx.com/), a free, open-source, high-performance HTTP server and reverse proxy, as well as an IMAP/POP3 proxy server. NGINX is known for its high performance, stability, rich feature set, simple configuration, and low resource consumption.

NGINX is one of a handful of servers written to address the [C10K problem](http://www.kegel.com/c10k.html). Unlike traditional servers, NGINX doesn’t rely on threads to handle requests. Instead it uses a much more scalable event-driven (asynchronous) architecture. This architecture uses small, but more importantly, predictable amounts of memory under load. Even if you don’t expect to handle thousands of simultaneous requests, you can still benefit from NGINX’s high-performance and small memory footprint. NGINX scales in all directions: from the smallest VPS all the way up to large clusters of servers.

### Prerequisites

Because NGINX needs to be compiled, basic compilation binaries are required. These prerequisites are met with the help of the [build-essential](https://supermarket.chef.io/cookbooks/build-essential) cookbook. Additionally ```pcre-devel```, ```openssl-devel```, ```zlib-devel``` are required for installing some of NGINX's most popular modules. These additional binaries are installed via Chef's package resource.

### Installation

@TODO

### Documentation

The following resources may be helpful to better understand NGINX usage:

@TODO
