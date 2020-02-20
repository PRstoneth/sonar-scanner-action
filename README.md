# Sonar Scanner docker action

This action runs sonar scanner on a codebase

## Inputs

### `sonar-url`

**Required** URL of the sonarqube host

### `command`

Optional    User defined command

## Outputs

## Example usage

uses: PRStoneth/sonar-scanner-action@v0.0.1
with:
  sonar-url: 'http://sonarurl:9000'
