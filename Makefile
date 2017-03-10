
all: build compress publish

publish:
	$(eval BASE_VERSION=$(shell grep 'flinkBaseVersion=' gradle.properties  | sed 's/flinkBaseVersion=//' | sed 's/-.*//'))
	$(eval GIT_COUNT=$(shell cd flink && git rev-list HEAD --count))
	$(eval GIT_COMMIT=$(shell cd flink && git rev-parse --short HEAD))
	$(eval VERSION=$(BASE_VERSION)-$(GIT_COUNT)-$(GIT_COMMIT))
	@echo $(VERSION)
	./gradlew artifactoryPublish -PflinkVersion=${VERSION}

build:
	cd flink; mvn clean package -DskipTests

compress:
	cd flink/flink-dist/target/flink-1.2-SNAPSHOT-bin; rm -rf flink-1.2.0.tgz; tar -cvzf flink-1.2.0.tgz flink-1.2-SNAPSHOT
