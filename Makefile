.dev-install:
	pip install pip-tools
	touch .dev-install

update: 
	pip-compile --output-file=requirements.txt requirements.in
	pip-sync requirements.txt
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

.publish-install:
	pip install twine build python-semantic-release
	touch .publish-install

update-version: .publish-install
	semantic-release version

publish: .publish-install
	semantic-release publish