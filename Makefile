all: dist/basicv2.jar

clean:
	rm -rf dist/basicv2.jar target

SRC := $(shell find src/main ! -path 'src/main/resources*')

target/basicv2-0.0.1-SNAPSHOT.jar: pom.xml $(SRC)
	mvn compile
	mvn package

dist/basicv2.jar: build_jar.xml target/basicv2-0.0.1-SNAPSHOT.jar
	ant -f build_jar.xml

.PHONY: all clean
