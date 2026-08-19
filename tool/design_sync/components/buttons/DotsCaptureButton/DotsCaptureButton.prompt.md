DotsCaptureButton from dots_design_system. Use via `window.DotsDesignSystem_9e41da.DotsCaptureButton` (bundle loaded from the root `_ds_bundle.js`). Ø80 camera capture button — `type: 'photo'` (white disc) / `'video'` (red disc); while video records it shows an animated white progress arc plus a red stop square; controlled via `state` or self-managed on click.

## Props

| Prop | Tipo | Default | Descripción |
| --- | --- | --- | --- |
| `type` | `'photo' \| 'video'` | `'photo'` | Tipo de captura (requerido en Dart). |
| `state` | `'active' \| 'recording'` | — | Controlado si se pasa; sin él, click alterna grabación (video). |
| `maxTimeRecording` | `number` | `60` | Segundos máximos: el arco llega a 360° y dispara `onStopRecording`. |
| `onTakePicture` | `() => void` | — | Click en modo photo. |
| `onStartRecording` | `() => void` | — | Click que inicia grabación (video). |
| `onStopRecording` | `() => void` | — | Click que la detiene, o fin del tiempo máximo. |

## Examples

```jsx
// Foto
<DotsCaptureButton type="photo" state="active" onTakePicture={shoot} />

// Vídeo controlado
<DotsCaptureButton type="video" state={rec ? 'recording' : 'active'}
  maxTimeRecording={30} onStartRecording={() => setRec(true)} onStopRecording={() => setRec(false)} />

// Vídeo no controlado (el botón gestiona el estado)
<DotsCaptureButton type="video" maxTimeRecording={15} />
```

Colócalo sobre el visor de cámara (fondo foto/vídeo); el aro exterior usa `bgContainerSecondary`.

## Dart mapping

- Widget: `DotsCaptureButton` (`lib/src/components/buttons/capture_button/`), enums `DotsCaptureButtonType.photo/video` y `DotsCaptureButtonState.active/recording`.
- Medidas: Ø80 (`_kCaptureButtonDiameter`), inner Ø68, photo·recording Ø60, ring stroke 6 con inset stroke/2 (radio 37) y cap redondeado, stop 32 × 32 r8.
- Colores: aro `bgContainerSecondary`; inner photo `labelAlwaysWhite`, video/stop `labelDestructive`; arco `labelAlwaysWhite`.
- El timer replica el `Timer.periodic` de 50 ms de Dart: progreso lineal hasta `maxTimeRecording` y `onStopRecording` al completarse.
- El modo no controlado (sin `state`) espeja el `_onTapDown` de Dart, que arranca/para la animación internamente.
