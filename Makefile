
all: build compress publish

publish:
	./gradlew artifactoryPublish

build:
	cd flink; mvn clean package -DskipTests

compress:
	cd flink/flink-dist/target/flink-1.2-SNAPSHOT-bin; rm -rf flink-1.2.0.tgz; tar -cvzf flink-1.2.0.tgz flink-1.2-SNAPSHOT
