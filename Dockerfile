FROM bellsoft/liberica-runtime-container:jdk-11-glibc

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

ENTRYPOINT ["java", "-jar",  "/home/mapgen/WurmMapGen.jar"]
