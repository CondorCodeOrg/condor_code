# ── Condor Code App (dev) ─────────────────────────────────────────
run-dev:
	cd apps/condor_code_app && fvm flutter run
run-dev-chrome:
	cd apps/condor_code_app && fvm flutter run -d chrome

# ── Condor Code App (staging) ─────────────────────────────────────
run-staging:
	cd apps/condor_code_app && fvm flutter run --dart-define=BUILD_TYPE=staging --dart-define=DATA_SOURCE=remote

run-staging-chrome:
	cd apps/condor_code_app && fvm flutter run -d chrome --dart-define=BUILD_TYPE=staging --dart-define=DATA_SOURCE=remote

# ── Condor Code App (prod) ────────────────────────────────────────
run-prod:
	cd apps/condor_code_app && fvm flutter run --dart-define=BUILD_TYPE=prod --dart-define=DATA_SOURCE=remote

run-prod-chrome:
	cd apps/condor_code_app && fvm flutter run -d chrome --dart-define=BUILD_TYPE=prod --dart-define=DATA_SOURCE=remote

# ── Admin App ─────────────────────────────────────────────────────
run-admin-dev:
	cd apps/condor_code_admin_app && fvm flutter run -d chrome --dart-define=BUILD_TYPE=dev

run-admin-staging:
	cd apps/condor_code_admin_app && fvm flutter run -d chrome --dart-define=BUILD_TYPE=staging

run-admin-prod:
	cd apps/condor_code_admin_app && fvm flutter run -d chrome --dart-define=BUILD_TYPE=prod

# ── Workspace commands ────────────────────────────────────────────

bootstrap:
	fvm dart run melos bootstrap

analyze:
	fvm dart run melos run analyze

fix:
	fvm dart run melos run fix

format:
	fvm dart run melos run format

check-format:
	fvm dart run melos run check-format

generate:
	fvm dart run melos run generate

check-generate:
	fvm dart run melos run check-generate

verify:
	fvm dart run melos run verify

prepush:
	fvm dart run melos run prepush

clean:
	fvm dart run melos run clean
	fvm dart run melos bootstrap

test:
	fvm dart run melos run test
