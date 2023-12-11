.dev-install:
	pip install pip-tools
	touch .dev-install

update: .dev-install
	pip-compile --output-file=requirements.txt requirements.in
	pip-compile --extra dev -o requirements-dev.txt pyproject.toml
	pip-sync requirements.txt requirements-dev.txt
	${MAKE} install

requirements.txt: .dev-install
	pip-compile --upgrade --output-file=requirements.txt requirements.in

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
	semantic-release version

publish: .publish-install
	semantic-release publish