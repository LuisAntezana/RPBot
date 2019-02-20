*** Settings ***
Library   OperatingSystem
Resource  ../resources/database.robot

*** Variables ***
${valid_output}       ${CURDIR}${/}..${/}testdata${/}one_suite${/}test_output.xml
${invalid_output}     ${CURDIR}${/}..${/}testdata${/}invalid_output.xml
${not_existing_file}  ${CURDIR}${/}..${/}testdata${/}not_existing.xml

*** Test Cases ***

Without arguments
    Run With ${EMPTY}
    Exits With Misused Arguments

With -h
    Run With -h
    Prints Help
    Exits With Success

With --help
    Run With --help
    Prints Help
    Exits With Success

With invalid option
    Run With --invalid
    Prints No Such Option --invalid
    Exits With Misused Arguments

With an existing file
    Run with ${valid_output}
    Exits With Success
    [Teardown]  Remove Database

With multiple existing files
    Run with ${valid_output} ${valid_output}
    Exits With Success
    [Teardown]  Remove Database

With no file names
    Run With ${EMPTY}
    Prints Input Files Required
    Exits With Misused Arguments

With not existing file
    Run With ${not_existing_file}
    Prints File ${not_existing_file} Not Exists
    Exits With Misused Arguments

With one of the files not existing
    Run with ${valid_output} ${not_existing_file}
    Exits With Misused Arguments

With an invalid XML file
    Run With ${invalid_output}
    Prints Parse Error In ${invalid_output}
    Exits With Error
    [Teardown]  Remove Database

With --database and database name
    [Setup]  Remove Database  ${own_database}
    ${rc}  ${output}=  Run With --database=${own_database_url} ${valid_output}
    Should Create Database  ${own_database}
    Should Not Create Default Database
    Exits With Success
    [Teardown]  Remove Database  ${own_database}

With --database and no database name
    [Setup]  Remove Database
    ${rc}  ${output}=  Run With --database
    Prints --database Requires Argument
    Should Not Create Default Database
    Exits With Misused Arguments

With -b and database name
    [Setup]  Remove Database  ${own_database}
    ${rc}  ${output}=  Run With -b ${own_database_url} ${valid_output}
    Should Create Database  ${own_database}
    Should Not Create Default Database
    Exits With Success
    [Teardown]  Remove Database  ${own_database}

With -b and no database file name
    [Setup]  Remove Database
    ${rc}  ${output}=  Run With -b
    Prints -b Requires Argument
    Should Not Create Default Database
    Exits With Misused Arguments

With -v
    ${rc}  ${output}=  Run With -v ${valid_output}
    Is Verbose
    Exits With Success

With --verbose
    ${rc}  ${output}=  Run With --verbose ${valid_output}
    Is Verbose
    Exits With Success

With -d
    [Setup]  Remove Database
    ${rc}  ${output}=  Run With -d ${valid_output}
    Should Not Create Default Database
    Exits With Success

With --dry-run
    [Setup]  Remove Database
    ${rc}  ${output}=  Run With --dry-run ${valid_output}
    Should Not Create Default Database
    Exits With Success

With -k
    ${rc}  ${output}=  Run With -k ${valid_output}
    Exits With Success

With --also-keywords
    ${rc}  ${output}=  Run With --also-keywords ${valid_output}
    Exits With Success


*** Keywords ***

Exits With ${value}
    Should Be Equal As Integers  ${TEST RC}  ${value}

Exits With Success
    Should Not Contain  ${TEST OUTPUT}  error:
    Should Be Equal As Integers  ${TEST RC}  0

Exits With Error
    Should Contain  ${TEST OUTPUT}  : error:
    Should Be Equal As Integers  ${TEST RC}  1

Exits With Misused Arguments
    Should Contain  ${TEST OUTPUT}  ${program_name}: error:
    Should Be Equal As Integers  ${TEST RC}  2

Exits With Help
    Prints Help
    Should Be Equal As Integers  ${TEST RC}  1

Prints Help
    Should Contain  ${TEST OUTPUT}  Options:

Prints Usage
    Should Contain  ${TEST OUTPUT}  Usage: ${program_name} [options]

Prints No Such Option ${option}
    Prints Usage
    Should Contain  ${TEST OUTPUT}  ${program_name}: error: no such option: ${option}

Prints Input Files Required
    Prints Usage
    Should Contain  ${TEST OUTPUT}  ${program_name}: error: at least one input file is required

Prints ${option} Requires Argument
    Prints Usage
    Should Contain  ${TEST OUTPUT}  ${program_name}: error: ${option} option requires 1 argument

Prints File ${filename} Not Exists
    Should Contain  ${TEST OUTPUT}  ${program_name}: error: file "${filename}" does not exist

Prints Parse Error In ${filename}
    Should Contain    ${TEST OUTPUT}    dbbot: error: Invalid XML: Reading XML source '${filename}' failed:

Is Verbose
    Should Contain    ${TEST OUTPUT}  DatabaseWriter |
    Should Contain    ${TEST OUTPUT}  Parser   |

Run With ${arguments}
    ${rc}  ${output}=  Run And Return Rc And Output  ${program_path} ${arguments}
    Set Test Variable    ${TEST RC}    ${rc}
    Set Test Variable    ${TEST OUTPUT}    ${output}
