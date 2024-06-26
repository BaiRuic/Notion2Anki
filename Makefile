.PHONY: \
	fmt \
	lint

all:
	@echo "fmt                 Format code."
	@echo "lint                Lint code."

FILES = notion2anki_addon tests

fmt:
	poetry run black $(FILES)
	poetry run isort $(FILES)

lint:
	poetry run black --check $(FILES)
	poetry run isort --check-only $(FILES)
	poetry run flake8 $(FILES)
	poetry run pydocstyle $(FILES)
	poetry run mypy $(FILES)

TEST_OUTPUT ?= .
test:
	poetry run py.test \
        --cov notion_sync_addon \
        --cov-report term-missing \
        --cov-report html:$(TEST_OUTPUT)/htmlcov \
        --cov-report xml:$(TEST_OUTPUT)/coverage.xml \
        --junit-xml $(TEST_OUTPUT)/junit.xml \
        tests
