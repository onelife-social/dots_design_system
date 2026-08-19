// DotsUploadItem — port de lib/src/components/upload_items/dots_upload_item.dart
// (+ upload_item_variant.dart → prop `variant`). Dart = fuente de verdad.
__ds.DotsUploadItem = (function () {
  'use strict';

  // UploadItemVariant → icono + color (mismo switch del Dart)
  var VARIANTS = {
    processing: { icon: 'ic-spinner', color: 'var(--text-secondary)' },
    success: { icon: 'ic-check-circle', color: 'var(--label-highlight)' },
    error: { icon: 'ic-cross-circle', color: 'var(--label-destructive)' },
  };

  function icon(p) {
    return __ds.DotsIcon
      ? h(__ds.DotsIcon, p)
      : h('span', {
          style: { display: 'inline-block', width: p.size + 'px', height: p.size + 'px' },
        });
  }

  function DotsUploadItem(props) {
    var variant = VARIANTS[props.variant] ? props.variant : 'processing';
    var v = VARIANTS[variant];
    var isProcessing = variant === 'processing';
    var isSuccess = variant === 'success';
    var isError = variant === 'error';
    var percentage = props.percentage == null ? null : Math.min(1, Math.max(0, props.percentage));

    // Imagen — DotsSquircleImage(size: 64, squircle16, uploadError: variant.isError)
    var photo = __ds.DotsSquirclePhoto
      ? h(__ds.DotsSquirclePhoto, {
          src: props.src,
          alt: props.alt,
          onError: props.onError,
          size: 64,
          borderRadius: 16,
          uploadError: isError,
        })
      : h('span', { className: 'ds-upload-item__photo-fallback' });

    // Fila de estado — icono 14 (girando si processing) + processText
    var processRow = h(
      'span',
      { className: 'ds-upload-item__process' },
      h(
        'span',
        {
          className:
            'ds-upload-item__process-icon' +
            (isProcessing ? ' ds-upload-item__process-icon--spin' : ''),
        },
        icon({ name: v.icon, size: 14, color: v.color })
      ),
      h('span', { className: 'ds-upload-item__process-text' }, props.processText || '')
    );

    // Progreso — DotsProgressBar(percentage, parts: 1) + '64%'
    var progressRow = null;
    if (isProcessing) {
      progressRow = h(
        'span',
        { className: 'ds-upload-item__progress' },
        h(
          'span',
          { className: 'ds-upload-item__progress-bar' },
          __ds.DotsProgressBar
            ? h(__ds.DotsProgressBar, { percentage: percentage == null ? 1 : percentage, parts: 1 })
            : h('span', { className: 'ds-upload-item__progress-fallback' })
        ),
        h(
          'span',
          { className: 'ds-upload-item__progress-pct' },
          percentage != null ? Math.round(percentage * 100) + '%' : ''
        )
      );
    }

    // Botón derecho — success: secondary · error: main (DotsMainButton medium)
    var button = null;
    if (!isProcessing) {
      button = __ds.DotsMainButton
        ? h(__ds.DotsMainButton, {
            label: props.btnText || '',
            variant: isSuccess ? 'secondary' : 'main',
            size: 'medium',
            expand: false,
            onClick: props.onBtnClick,
          })
        : h(
            'button',
            {
              type: 'button',
              className:
                'ds-upload-item__btn-fallback ds-upload-item__btn-fallback--' +
                (isSuccess ? 'secondary' : 'main'),
              onClick: props.onBtnClick,
            },
            props.btnText || ''
          );
    }

    return h(
      'div',
      { className: 'ds-upload-item' + (props.className ? ' ' + props.className : '') },
      photo,
      h(
        'div',
        {
          className:
            'ds-upload-item__body' + (isProcessing ? ' ds-upload-item__body--processing' : ''),
        },
        h('div', { className: 'ds-upload-item__date' }, props.textDate || ''),
        processRow,
        progressRow,
        isSuccess
          ? h('div', { className: 'ds-upload-item__elapsed' }, props.timeElapsed || '')
          : null
      ),
      button
    );
  }

  return DotsUploadItem;
})();
