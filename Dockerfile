FROM openjdk:11

RUN apt update && apt install unzip

WORKDIR /home/mapgen
RUN mkdir wurmsave wurmhttp

RUN adduser --disabled-password --shell /bin/bash mapgen \
    && chown -R mapgen:mapgen /home/mapgen
ENV LANG en_US.utf8

COPY --chmod=755 *.zip /home/mapgen
COPY --chmod=755 start.sh /home/mapgen/

USER mapgen
RUN unzip *.zip
COPY --chmod=755 WurmMapGen.properties /home/mapgen/

ENTRYPOINT ["/home/mapgen/start.sh"]
