FROM openjdk:17-alpine

LABEL org.opencontainers.image.vendor="ghcr.io"
LABEL org.opencontainers.image.title="PaperImage"
LABEL org.opencontainers.image.description="Docker Image to run a papermc minecraft server"
LABEL org.opencontainers.image.source=https://github.com/l3nnartt/paperimage
LABEL org.opencontainers.image.authors="Lennart Lösche <contact@lennartloesche.de>"
LABEL org.opencontainers.image.version=1.19.3-336

EXPOSE 25565

WORKDIR /opt/paper/
ADD https://api.papermc.io/v2/projects/paper/versions/1.19.3/builds/336/downloads/paper-1.19.3-336.jar paper.jar
ADD eula.txt eula.txt

RUN apk --update add --no-cache ca-certificates

CMD java -Xms1G -Xmx2G -XX:+UseG1GC -XX:+ParallelRefProcEnabled -XX:MaxGCPauseMillis=200 -XX:+UnlockExperimentalVMOptions -XX:+DisableExplicitGC -XX:+AlwaysPreTouch -XX:G1NewSizePercent=30 -XX:G1MaxNewSizePercent=40 -XX:G1HeapRegionSize=8M -XX:G1ReservePercent=20 -XX:G1HeapWastePercent=5 -XX:G1MixedGCCountTarget=4 -XX:InitiatingHeapOccupancyPercent=15 -XX:G1MixedGCLiveThresholdPercent=90 -XX:G1RSetUpdatingPauseTimePercent=5 -XX:SurvivorRatio=32 -XX:+PerfDisableSharedMem -XX:MaxTenuringThreshold=1 -Dusing.aikars.flags=https://mcflags.emc.gs -Daikars.new.flags=true -jar paper.jar --nogui
