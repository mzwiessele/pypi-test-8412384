.dev-install:
	pip install pip-tools
	touch .dev-install

update: .dev-install
	pip-compile --output-file=requirements.txt requirements.in --strip-extras
	pip-compile --extra dev -o requirements-dev.txt pyproject.toml
	pip-sync requirements.txt requirements-dev.txt
	${MAKE} install

requirements.txt: .dev-install
	pip-compile --upgrade --output-file=requirements.txt requirements.in --strip-extras

install: requirements.txt
	pip install -e .

clean:
	rm -f requirements.txt

lint:
	black pypi_test_8412384
	ruff --fix pypi_test_8412384

lint-check:
	black --check --diff pypi_test_8412384
	ruff check pypi_test_8412384


version: .publish-install
	${MAKE} update
	git add requirements.txt requirements-dev.txt
	semantic-release version

version-local: .publish-install
	semantic-release -vv version

publish: .publish-install
	semantic-release publish