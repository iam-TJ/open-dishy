# Investigating Javascript files
```
dishy.starlink.com/assets/api.bundle.web.js
dishy.starlink.com/assets/app.bundle.web.js
```

These files are served by the User Terminal. Here we document the various libraries that are embedded as the first step towards enabling us to create our own implementation. By identifying the third party libraries we can do two things:

  1. Reproduce the build of the open-source code
  2. Identify the Starlink specific code

That will enable implemention of a completely new, open-source, interface - and that will allow adding functionality.

## Observations and Deductions

  * Written in TypeScript
  * Uses React
  * Uses WebPack

## Third Party Libraries identified

Analysis is done on the un-minified code produced by Firefox developer tools Pretty Print functionality.

### app.bundle.web.2023_mod.js
| Licence    | Project | Identifier |
| ---------- | ------- | ---------- |
| MIT | (https://github.com/facebook/react/) | `https://reactjs.org/docs/error-decoder.html` |
| MIT | (https://github.com/markedjs/marked) | `'\nPlease report this to https://github.com/markedjs/marked.'` |
| MIT | (https://github.com/ai/nanoid) | `ModuleSymbhasOwnPr-0123456789ABCDEFGHNRVfgctiUvz_KqYTJkLxpZXIjQW` |
| MIT | (https://github.com/fantasyland/fantasy-land) | `fantasy-land/equals` |
| Apache 2.0 | (https://github.com/cognitect-labs/transducers-js) | `transducer/step` |
| MIT or GPLv3  | (https://github.com/Stuk/jszip) | `Corrupted zip or bug : unexpected signature` |
| MIT | (https://github.com/davidbau/seedrandom) | `c.tychei =` |
| MIT  | (https://github.com/opentypejs/opentype.js) | `Unsupported OpenType flavor ` |
| MIT  | (https://github.com/mrdoob/three.js/) | `ACESFilmicToneMapping` |
| MIT  | (https://github.com/hammerjs/hammer.js) | `emit('hammer.input'` |

Starlink specific code appears to start at line 161039.

#### Language-specific configuration and strings:

These are badly encoded; each language table is around 78KiB in size and contains both English and Translated strings, so English is repeated many times, enlarging the resulting code unnecessarily - especially considering the minification.

| Line | Code | Language | Var |
| ---- | ---- | -------- | --- |
| 149372 | de_DE | German | Hr |
| 149375 | el | Greek | Qr |
| 149378 | es | Spanish | xr |
| 149381 | fr_CA | French Canadian | Vr |
| 149384 | fr_FR | French | Gr |
| 149387 | it | Italian | Wr |
| 149390 | pl | Polish | Ur |
| 149394 | pt_BR | Brazilian | Yr |
| 149402 | pt_PT | Portugese | jr |



TODO: complete analysis of script

### api.bundle.web.js

TODO: analyse script
