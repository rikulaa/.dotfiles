# Can run 4 parallel jobs at the same time
MAKEFLAGS += --jobs 4

.PHONY: help
help:           ## Show this help.
	@awk 'BEGIN {FS = ":.*##"; printf "\Targets:\n  \033[36m\033[0m\n"} /^[$$()% a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)

# Wildcards
# https://lithic.tech/blog/2020-05/makefile-wildcards
#
migrate-to-%:
	bundle exec rake migrate[$(*)]
