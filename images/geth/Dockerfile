FROM ethereum/client-go

ENTRYPOINT ["geth"]
CMD ["--http", "--http.addr", "0.0.0.0", "--http.port", "8545", "--ws", "--ws.addr", "0.0.0.0", "--ws.port", "8546", "-http.vhosts", "*"]