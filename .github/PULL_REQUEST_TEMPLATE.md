## Qué cambia

<!-- Descripción breve. Si cierra una tarea, enlázala. -->

## Release

Al mergear se crea el tag y la GitHub Release automáticamente según la label de la PR. Pon **una**:

- [ ] `release:patch` — fix sin cambio de API
- [ ] `release:minor` — componente/prop nuevo, compatible hacia atrás
- [ ] `release:major` — rompe API (renombrados, props eliminadas, cambios de comportamiento)
- [ ] `release:skip` — docs, CI, tooling; no necesita tag

<!-- Sin label el check "Release label" falla y no se puede mergear. -->
