#! /usr/bin/env bash
#npm run asset_db
npx playwright test --config=playwright.config.ts
#npx allure serve allure-results -p 7919
#echo "Running Playwright tests..."
#
#if [[ -v "CRONJOB_SCHEDULE" ]]; then
#   npx playwright test --config=playwright.cronjob.config.ts
#else
#   npx playwright test --config=playwright.config.ts
#fi
#
#cp -r mnt/allure-report/history allure-results/history
#rm -rf mnt/allure-report
#npx allure generate allure-results -o mnt/allure-report
## Check if the tests passed before proceeding
#if [ $? -eq 0 ]; then
#  /app/create_cronjob.sh
#  echo "Tests passed. Starting Allure server..."
#
#  # Run Allure server
#  npx allure serve allure-results -p 7919
#else
#  echo "Tests failed. Not starting Allure server."
#  exit 1
#fi