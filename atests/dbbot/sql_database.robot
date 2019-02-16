*** Settings ***
Library           OperatingSystem
Library           ../libraries/RobotSqliteDatabase.py
Resource          ../resources/database.robot
Test Teardown     Disconnect And Cleanup

*** Variables ***

${test_run}                 ${CURDIR}${/}..${/}testdata${/}one_suite${/}test_output.xml
${latter_test_run}          ${CURDIR}${/}..${/}testdata${/}one_suite${/}output_latter.xml
${test_run_with_subsuites}  ${CURDIR}${/}..${/}testdata${/}multiple${/}test_output.xml

*** Test Cases ***

Single test run results
    [Setup]    Parse Without Keywords ${test_run}
    Should Have 1 Test Runs

Single test run multiple times
    [Setup]    Parse Without Keywords ${test_run} ${test_run}
    Should Have 1 Test Runs

Single test run without keywords
    [Setup]  Parse Without Keywords ${test_run}
    Should Have Suites And Tests
    Should Not Store Keywords

Single test run with keywords
    [Setup]  Parse With Keywords ${test_run}
    Should Have Suites And Tests
    Should Have Keywords

Single test run with subsuites
    [Setup]  Parse With Keywords ${test_run_with_subsuites}
    Should Have 1 Test Runs
    Should Have 2 Test Run Statuses
    Should Have 0 Test Run Errors
    Should Have 4 Suites
    Should Have 4 Suite Statuses
    Should Have 50 Tests
    Should Have 50 Test Statuses
    Should Have 150 Tags
    Should Have 3 Tag Statuses
    Should Have 41 Keywords
    Should Have 381 Keyword Statuses
    Should Have 139 Arguments
    Should Have 176 Messages

Multiple test runs with the same root suite
    [Setup]  Parse With Keywords ${test_run} ${latter_test_run}
    Should Have ${2*1} Test Runs
    Should Have ${2*2} Test Run Statuses
    Should Have 0 Test Run Errors
    Should Have 1 Suites
    Should Have 2 Suite Statuses
    Should Have 19 Tests
    Should Have ${2*19} Test Statuses
    Should Have 57 Tags
    Should Have ${2*3} Tag Statuses
    Should Have 39 Keywords
    Should Have ${2*216} Keyword Statuses
    Should Have 131 Arguments
    Should Have 99 Messages
    [Teardown]  Disconnect And Cleanup

*** Keywords ***

Parse Without Keywords ${files}
    Remove Database
    Run  ${program_path} ${files}
    Connect To Database  ${default_database}

Parse With Keywords ${files}
    Remove Database
    Run  ${program_path} ${files} --also-keywords
    Connect To Database  ${default_database}

Disconnect And Cleanup
    Close Connection
    Remove Database  ${default_database}

Should Have ${n} Test Runs
    Row Count Is Equal To  ${n}  test_runs

Should Have ${n} Test Run Statuses
    Row Count Is Equal To  ${n}  test_run_status

Should Have ${n} Test Run Errors
    Row Count Is Equal To  ${n}  test_run_errors

Should Have ${n} Suites
    Row Count Is Equal To  ${n}  suites

Should Have ${n} Suite Statuses
    Row Count Is Equal To  ${n}  suite_status

Should Have ${n} Tests
    Row Count Is Equal To  ${n}  tests

Should Have ${n} Test Statuses
    Row Count Is Equal To  ${n}  test_status

Should Have ${n} Tags
    Row Count Is Equal To  ${n}  tags

Should Have ${n} Tag Statuses
    Row Count Is Equal To  ${n}  tag_status

Should Have ${n} Keywords
    Row Count Is Equal To  ${n}  keywords

Should Have ${n} Keyword Statuses
    Row Count Is Equal To  ${n}  keyword_status

Should Have ${n} Arguments
    Row Count Is Equal To  ${n}  arguments

Should Have ${n} Messages
    Row Count Is Equal To  ${n}  messages

Should Have Suites and Tests
    Should Have 1 Test Runs
    Should Have 2 Test Run Statuses
    Should Have 0 Test Run Errors
    Should Have 1 Suites
    Should Have 1 Suite Statuses
    Should Have 19 Tests
    Should Have 19 Test Statuses
    Should Have 57 Tags
    Should Have 3 Tag Statuses

Should Have Keywords
    Should Have 39 Keywords
    Should Have 216 Keyword Statuses
    Should Have 131 Arguments
    Should Have 87 Messages

Should Not Store Keywords
    Should Have 0 Keywords
    Should Have 0 Keyword Statuses
    Should Have 0 Arguments
    Should Have 0 Messages
