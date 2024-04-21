# Investigating Javascript files
```
dishy.starlink.com/assets/api.bundle.web.js
dishy.starlink.com/assets/app.bundle.web.js
```

These files are served by the User Terminal. Here we document the various libraries that are embedded as the first step towards enabling us to create our own implementation.

## Observations and Deductions

  * Written in TypeScript
  * Uses React
  * Uses WebPack

## Third Party Libraries identified

### app.bundle.web.js
| Licence    | Project | Identifier |
| ---------- | ------- | ---------- |
| MIT | (https://github.com/facebook/react/) | `https://reactjs.org/docs/error-decoder.html` |
| MIT | (https://github.com/markedjs/marked) | `'\nPlease report this to https://github.com/markedjs/marked.'` |
| MIT | (https://github.com/ai/nanoid) | `ModuleSymbhasOwnPr-0123456789ABCDEFGHNRVfgctiUvz_KqYTJkLxpZXIjQW` |
| MIT | (https://github.com/fantasyland/fantasy-land) | `fantasy-land/equals` |
| Apache 2.0 | (https://github.com/cognitect-labs/transducers-js) | `transducer/step` |
| MIT or GPLv3  | (https://github.com/Stuk/jszip/tree/main) | `Corrupted zip or bug : unexpected signature` |
| MIT | (https://github.com/davidbau/seedrandom) | `c.tychei =` |

TODO: complete analyse of script

### api.bundle.web.js

TODO: analyse script
