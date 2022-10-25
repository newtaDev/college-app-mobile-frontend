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

cleanup: ## Format clean and install the project.
cleanup: format clean install

install: ## Install the whole project.
	@./scripts/install.sh 

analyze: ## Analyze the whole project.
	@./scripts/analyze.sh

clean: ## Cleaning the whole project.
	@./scripts/clean.sh
fix: ## fix dart/flutter warnigs/problems in the project.
	@dart fix --apply

localizations: ## Generate localizations for app.
	@./scripts/localizations.sh 

format: ## Format the whole project.
	@echo
	@echo "╠ ---- Formatting the code ----"
	@echo
	@flutter format .

build_runner: ## Generate code using build_runner
	flutter pub run build_runner build --delete-conflicting-outputs

clean_ios: ## Clean pod file
	cd ios && pod deintegrate --verbose && pod install

# test: ## Test the whole project.
# 	@echo "╠ Testing the project..."
# 	@./scripts/test.sh 

# launch: ## Run the app.
# 	@echo "╠ Running the project..."
# 	@cd app; flutter run -t lib/main_qa.dart
