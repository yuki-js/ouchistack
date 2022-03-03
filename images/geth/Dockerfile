FROM ethereum/client-go

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh


EXPOSE 8545 8546 30303 30303/udp

RUN mkdir /datadir
RUN mkdir /ancient

RUN adduser -S user
RUN chown user /datadir && chown user /ancient
USER user

ENTRYPOINT ["/entrypoint.sh"]