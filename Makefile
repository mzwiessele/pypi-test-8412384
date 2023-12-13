.dev-install:
	pip install pip-tools
	touch .dev-install

update-local: .dev-install requirements.txt requirements-dev.txt
	pip-sync requirements.txt requirements-dev.txt
	${MAKE} install

requirements.txt: .dev-install
	pip-compile --upgrade --output-file=requirements.txt requirements.in --strip-extras

requirements-dev.txt: .dev-install
	pip-compile --extra dev -o requirements-dev.txt pyproject.toml

install: requirements.txt
	pip install -e .

dev-install: requirements.txt requirements-dev.txt
	pip install -r requirements.txt
	pip install -r requirements-dev.txt
	pip install -e .

clean:
	rm -f requirements.txt requirements-dev.txt

lint:
	black pypi_test_8412384
	ruff --fix pypi_test_8412384

lint-check:
	black --check --diff pypi_test_8412384
	ruff check pypi_test_8412384

version-local: .publish-install
	semantic-release -vv version

publish: .publish-install
	semantic-release publish