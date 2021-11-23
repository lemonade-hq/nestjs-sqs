cleanup-docker:
	docker rm -f elasticmq;
elasticmq: cleanup-docker
	docker run -d -p 9324:9324 --mount type=bind,source=$(shell pwd)/.github/build/elasticmq.conf,target=/etc/elasticmq/elasticmq.conf --name elasticmq s12v/elasticmq
e2e-test:
	npm run test:e2e
do-publish:
	git diff --exit-code
	git diff --cached --exit-code
	npm run build
	npm version prerelease --preid lmnd
	npm publish

publish: elasticmq e2e-test cleanup-docker do-publish
