# 작성자: 이웅희
#
# Step 1: Base image
FROM openjdk:11

# Step 2: Install required packages and sbt
RUN apt-get update && apt-get install -y apt-transport-https curl gnupg && \
    echo "deb https://repo.scala-sbt.org/scalasbt/debian all main" | tee /etc/apt/sources.list.d/sbt.list && \
    echo "deb https://repo.scala-sbt.org/scalasbt/debian /" | tee /etc/apt/sources.list.d/sbt_old.list && \
    curl -sL "https://keyserver.ubuntu.com/pks/lookup?op=get&search=0x2EE0EA64E40A89B84B2DF73499E82A75642AC823" | \
    gpg --no-default-keyring --keyring gnupg-ring:/etc/apt/trusted.gpg.d/scalasbt-release.gpg --import && \
    chmod 644 /etc/apt/trusted.gpg.d/scalasbt-release.gpg && \
    apt-get update && \
    apt-get install -y sbt

# Step 3: Set working directory
WORKDIR /app

# Step 4: Copy the project files
COPY . .

# Step 5: Set JVM options to increase the heap size
ENV SBT_OPTS="-Xmx4G"

# Step 6: Build the project
RUN sbt compile

# Step X: Set the entrypoint to sbt
# ENTRYPOINT ["sbt", "runMain", "org.allenai.pdffigures2.FigureExtractorBatchCli"]

# By default, the container will run `sbt runMain` with no arguments
CMD []
