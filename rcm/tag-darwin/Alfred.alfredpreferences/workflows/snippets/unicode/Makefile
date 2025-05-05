
DIR_BUILD := build

FILES_PYTHON := $(wildcard *.py)

$(DIR_BUILD):
	mkdir $(DIR_BUILD)

$(DIR_BUILD)/favorite-chars.pickle: | $(DIR_BUILD);

$(DIR_BUILD)/results-fav-chars.json: $(FILES_PYTHON) build/favorite-chars.pickle | $(DIR_BUILD)
	python3 make-favorite-chars-results.py > $(DIR_BUILD)/results-fav-chars.json

$(DIR_BUILD)/results-all-chars.json: $(FILES_PYTHON) | $(DIR_BUILD)
	python3 make-all-chars-results.py > $(DIR_BUILD)/results-all-chars.json

.PHONY: clean
clean:
	-rm -rf $(DIR_BUILD)

