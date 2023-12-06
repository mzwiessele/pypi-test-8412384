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
	black azure_form_recogniser panels
	ruff --fix azure_form_recogniser panels

lint-check:
	black --check --diff azure_form_recogniser panels
	ruff check azure_form_recogniser panels


update-version: .publish-install
	${MAKE} update
	semantic-release version

publish: .publish-install
	semantic-release publish