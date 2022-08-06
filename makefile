SHELL = /bin/sh
.PHONY: clean localizations analyze install format test launch

help: ## This help dialog.
	@IFS=$$'\n' ; \
	help_lines=(`fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//'`); \
	for help_line in $${help_lines[@]}; do \
		IFS=$$'#' ; \
		help_split=($$help_line) ; \
		help_command=`echo $${help_split[0]} | sed -e 's/^ *//' -e 's/ *$$//'` ; \
		help_info=`echo $${help_split[2]} | sed -e 's/^ *//' -e 's/ *$$//'` ; \
		printf "%-30s %s\n" $$help_command $$help_info ; \
	done

setup: ## Formats cleans and install on the project.
setup: format clean install

install: ## Install the whole project.
	@./scripts/install.sh 

analyze: ## Analyze the whole project.
	@./scripts/analyze.sh

clean: ## Cleaning the whole project.
	@./scripts/clean.sh

localizations: ## Generate localizations for app.
	@./scripts/localizations.sh 

format: ## Format the whole project.
	@echo
	@echo "╠ ---- Formatting the code ----"
	@echo
	@flutter format .
# test: ## Test the whole project.
# 	@echo "╠ Testing the project..."
# 	@./scripts/test.sh 

# launch: ## Run the app.
# 	@echo "╠ Running the project..."
# 	@cd app; flutter run -t lib/main_qa.dart
