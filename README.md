# Bitcoin Price Plasmoid

## About
Plasma applet showing the current air pollution for Polish city.

Written by Marek

## Installation
```
plasmapkg2 -i package
```

Use additional `-g` flag to install plasmoid globally, for all users.

## Debugging

```
plasmoidviewer -a package
```

Plasmoid viewer is part of plasma-sdk. Message printing can be done with "console.log()" method.

## Supported sources
- api.gios.gov.pl/pjp-api/rest (documentation: http://powietrze.gios.gov.pl/pjp/content/api)