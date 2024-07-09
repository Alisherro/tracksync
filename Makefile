.PHONY: run build_dev build_prod test

build_dev:
	@echo "Running Flutter app with environment variables from .env.dev.json"
	fvm flutter run --dart-define-from-file=.env.dev.json

build_prod:
	@echo "Building Flutter app with environment variables from .env.prd.json"
	fvm flutter build apk --dart-define-from-file=.env.prd.json

test:
	@echo "Running Flutter tests"
	fvm flutter test
