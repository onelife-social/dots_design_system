// MessagePreview — port de lib/src/components/chat/message_preview.dart
// (+ chat/enum/message_type_enum.dart → prop `attachmentType`). Dart = fuente de verdad.
__ds.MessagePreview = (function () {
  'use strict';

  // MessageType (isAttachment = != text) → icono del adjunto en la preview
  var ATTACHMENT_ICONS = {
    image: 'ic-pic',
    video: 'ic-video',
    audio: 'ic-mic',
    file: 'ic-pages',
  };

  function gradVariant(seed) {
    var s = String(seed == null ? '' : seed);
    var n = 0;
    for (var i = 0; i < s.length; i++) n = (n + s.charCodeAt(i)) % 997;
    return 'abcd'[n % 4];
  }

  function icon(p) {
    return __ds.DotsIcon
      ? h(__ds.DotsIcon, p)
      : h('span', {
          style: { display: 'inline-block', width: p.size + 'px', height: p.size + 'px' },
        });
  }

  function MessagePreview(props) {
    var useState = hooks().useState;
    var errState = useState(false);
    var hasError = errState[0];
    var setError = errState[1];

    var album = props.album || '';
    var newMessages = props.newMessages || 0;
    var typing = props.typingText != null && props.typingText !== '';
    var showImg = !!props.src && !hasError;

    // _ImageAlbum — 56×56 squircle16; placeholder degradado con inicial del álbum
    var image = h(
      'span',
      { className: 'ds-msg-preview__img' },
      showImg
        ? h('img', {
            className: 'ds-msg-preview__img-el',
            src: props.src,
            alt: album,
            onError: function (e) {
              setError(true);
              if (props.onError) props.onError(e);
            },
          })
        : h(
            'span',
            { className: 'ds-msg-preview__img-ph ds-msg-preview__img-ph--' + gradVariant(album) },
            album ? album.charAt(0).toUpperCase() : ''
          )
    );

    // _ChatContent — typingText anula sender + attachment + message (Dart)
    var content;
    if (typing) {
      content = [h('span', { key: 't' }, props.typingText)];
    } else {
      content = [];
      if (props.senderName) {
        content.push(
          h('span', { key: 's', className: 'ds-msg-preview__sender' }, props.senderName + ': ')
        );
      }
      var attachmentIcon =
        props.attachmentIcon ||
        (props.attachmentType && props.attachmentType !== 'text'
          ? ATTACHMENT_ICONS[props.attachmentType]
          : null);
      if (attachmentIcon) {
        content.push(
          h(
            'span',
            { key: 'a', className: 'ds-msg-preview__attach' },
            icon({ name: attachmentIcon, size: 13, color: 'currentColor' })
          ),
          ' '
        );
      }
      content.push(props.message || '');
    }

    return h(
      'div',
      {
        className: 'ds-msg-preview' + (props.className ? ' ' + props.className : ''),
        onClick: props.onClick,
        role: props.onClick ? 'button' : undefined,
      },
      h(
        'div',
        { className: 'ds-msg-preview__inner' },
        image,
        h(
          'div',
          { className: 'ds-msg-preview__col' },
          // _ChatHeaderInfo — album bodyLargeBold + time bodyDefaultRegular
          h(
            'div',
            { className: 'ds-msg-preview__header' },
            h('span', { className: 'ds-msg-preview__album' }, album),
            h('span', { className: 'ds-msg-preview__time' }, props.time || '')
          ),
          h(
            'div',
            { className: 'ds-msg-preview__content' },
            h.apply(null, ['span', { className: 'ds-msg-preview__text' }].concat(content)),
            // BadgeTag — píldora labelDestructive, cap '+999'
            newMessages > 0
              ? h(
                  'span',
                  { className: 'ds-msg-preview__badge' },
                  newMessages > 999 ? '+999' : String(newMessages)
                )
              : null
          )
        )
      )
    );
  }

  return MessagePreview;
})();
