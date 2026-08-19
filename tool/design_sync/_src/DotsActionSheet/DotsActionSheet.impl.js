// DotsActionSheet — port de lib/src/components/action_sheet/ (Dart = fuente de verdad).
// API única con `variant`: standard | list | input | radioButtons | settings | search | spotlight.
// Mapeo a Dart: standard→DotsActionSheetStandard, list→DotsActionSheetList,
// input→DotsActionSheetInput, radioButtons→DotsActionSheetRadioButtons,
// settings→DotsActionSheetSettings, search→DotsActionSheetSearch,
// spotlight→DotsActionSheetSpotlight. Se renderiza como hoja estática montable
// (position relative, sin scrim ni posicionamiento modal).
__ds.DotsActionSheet = (function () {
  'use strict';

  function icon(p) {
    return __ds.DotsIcon
      ? h(__ds.DotsIcon, p)
      : h('span', { style: { display: 'inline-block', width: p.size + 'px', height: p.size + 'px' } });
  }

  function mainButton(p) {
    if (__ds.DotsMainButton) return h(__ds.DotsMainButton, p);
    return h('button', {
      type: 'button',
      className: 'ds-action-sheet__btn-fallback' + (p.size === 'large' ? ' ds-action-sheet__btn-fallback--h44' : ''),
      disabled: p.enabled === false,
      onClick: p.onClick,
    }, p.label);
  }

  function closeButton(props, top) {
    // Dart: DotsCloseButton medium softContrast addBlur=false, top 16 (12 en radioButtons/spotlight), right 16
    var btn = __ds.DotsCloseButton
      ? h(__ds.DotsCloseButton, { size: 'medium', variant: 'softContrast', addBlur: false, onClick: props.onClose })
      : h('button', { type: 'button', className: 'ds-action-sheet__close-fallback', 'aria-label': 'Cerrar', onClick: props.onClose }, '×');
    return h('span', { className: 'ds-action-sheet__close', style: top ? { top: top + 'px' } : null }, btn);
  }

  function textField(p) {
    if (__ds.DotsTextField) return h(__ds.DotsTextField, p);
    return h('div', { className: 'ds-action-sheet__field-fallback' + (p.alignCenter ? ' is-center' : '') },
      p.icon ? icon({ name: p.icon, size: 16, color: 'currentColor' }) : null,
      p.hintText || '');
  }

  function radioControl(selected, onChanged) {
    if (__ds.DotsRadioButton) return h(__ds.DotsRadioButton, { isSelected: selected, onChanged: onChanged });
    return h('span', { className: 'ds-action-sheet__radio-fallback' + (selected ? ' is-on' : '') });
  }

  function grabber() {
    return h('div', { className: 'ds-action-sheet__grabber' });
  }

  // ── DotsActionSheet.ListItem — dots_list_item.dart ─────────────────────────
  // { icon: string | iconNode: node, label, showLockIcon, onClick }
  function ListItem(p) {
    return h(
      'div',
      { className: 'ds-action-sheet__list-item', role: 'button', tabIndex: 0, onClick: p.onClick },
      h('span', { className: 'ds-action-sheet__list-item-icon' },
        p.iconNode || (p.icon ? icon({ name: p.icon, size: 20, color: 'var(--text-tertiary)' }) : null)),
      h('span', { className: 'ds-action-sheet__list-item-label' },
        p.label,
        p.showLockIcon ? icon({ name: 'ic-lock', size: 14, color: 'var(--text-secondary)', className: 'ds-action-sheet__list-item-lock' }) : null)
    );
  }

  // Botonera estándar (DotsActionSheetStandardButtons): row (secondary | primary) o column
  function footerButtons(props, size) {
    var primary = props.primaryButton ||
      (props.primaryLabel != null
        ? mainButton({ label: props.primaryLabel, variant: 'main', size: size || 'mainAction', enabled: props.primaryEnabled !== false, onClick: props.onPrimaryTap })
        : null);
    var secondary = props.secondaryButton ||
      (props.secondaryLabel != null
        ? mainButton({ label: props.secondaryLabel, variant: 'secondary', size: size || 'mainAction', onClick: props.onSecondaryTap })
        : null);
    if (!primary && !secondary) return null;
    var column = props.buttonPositioning === 'column';
    return h('div', { className: 'ds-action-sheet__buttons' + (column ? ' ds-action-sheet__buttons--column' : '') },
      column ? primary : secondary, column ? secondary : primary);
  }

  function titleBlock(title, cls, key) {
    return title != null ? h('p', { className: cls, key: key }, title) : null;
  }

  // ── Variantes ──────────────────────────────────────────────────────────────

  function renderStandard(props) {
    // DotsActionSheetStandardContent: grabber → topWidget → title (title02H5) →
    // description → bottomWidget → stepProgress → botones
    var spacing = props.bigAspectRatio === false ? 16 : 20; // Dart: bigAspectRatio default true
    var gap = { marginTop: spacing + 'px' };
    return [
      props.topContent ? h('div', { key: 'top', className: 'ds-action-sheet__pad16', style: gap }, props.topContent) : null,
      h('div', { key: 'head', className: 'ds-action-sheet__pad16', style: gap },
        titleBlock(props.title, 'ds-action-sheet__title-h5'),
        props.description ? h('p', { className: 'ds-action-sheet__description' }, props.description) : null),
      props.children ? h('div', { key: 'body', className: 'ds-action-sheet__pad16', style: gap }, props.children) : null,
      props.bottomContent ? h('div', { key: 'bottom', className: 'ds-action-sheet__full', style: gap }, props.bottomContent) : null,
      props.stepProgress > 0
        ? h('div', { key: 'prog', className: 'ds-action-sheet__progress', style: gap },
            h('div', { className: 'ds-action-sheet__progress-fill', style: { width: Math.min(props.stepProgress, 1) * 100 + '%' } }))
        : null,
      h('div', { key: 'btns', className: 'ds-action-sheet__pad16 ds-action-sheet__footer', style: { marginTop: spacing + 'px' } },
        footerButtons(props)),
    ];
  }

  function renderList(props) {
    // DotsActionSheetListContent: header (título h6 + back/label btn + búsqueda +
    // chips) → lista con DotsListItem → botón mainAction (o icon-label si ghost)
    var isGhost = props.listVariant === 'ghost'; // ActionSheetListVariant
    var chips = props.selectedItems || [];
    var items = props.items || [];
    return [
      h('div', { key: 'head', className: 'ds-action-sheet__list-header' },
        props.showBackButton
          ? h('button', { type: 'button', className: 'ds-action-sheet__back', 'aria-label': 'Atrás', onClick: props.onBack },
              icon({ name: 'ic-chevron-left', size: 20, color: 'var(--text-primary)' }))
          : null,
        titleBlock(props.title, 'ds-action-sheet__title-h6'),
        props.labelButtonText != null
          ? h('span', { className: 'ds-action-sheet__label-btn' },
              mainButton({ label: props.labelButtonText, variant: 'main', size: 'small', expand: false, enabled: props.labelButtonEnabled !== false, onClick: props.onLabelButtonTap }))
          : null),
      props.description ? h('p', { key: 'desc', className: 'ds-action-sheet__description ds-action-sheet__description--quarternary' }, props.description) : null,
      h('div', { key: 'search', className: 'ds-action-sheet__pad16 ds-action-sheet__search-row' },
        textField({ icon: props.searchIcon || 'ic-search', hintText: props.searchHint, value: props.searchValue, onChanged: props.onSearchChanged })),
      chips.length
        ? h('div', { key: 'chips', className: 'ds-action-sheet__chips' },
            chips.map(function (c, i) {
              return h('span', { key: c.id != null ? c.id : i, className: 'ds-action-sheet__chip' },
                c.name,
                h('span', {
                  className: 'ds-action-sheet__chip-close',
                  role: 'button',
                  onClick: function () { if (props.onChipTap) props.onChipTap(c.id); },
                }, icon({ name: 'ic-cross', size: 10, color: 'currentColor' })));
            }))
        : null,
      h('div', { key: 'list', className: 'ds-action-sheet__list' },
        props.listTitle ? h('span', { className: 'ds-action-sheet__list-title' }, props.listTitle) : null,
        props.children || items.map(function (it, i) { return h(ListItem, Object.assign({ key: i }, it)); })),
      h('div', { key: 'btns', className: 'ds-action-sheet__pad16 ds-action-sheet__footer' },
        isGhost && props.primaryLabel != null
          ? h('button', { type: 'button', className: 'ds-action-sheet__ghost-btn', onClick: props.onPrimaryTap },
              h('span', { className: 'ds-action-sheet__ghost-btn-icon' }, icon({ name: props.mainButtonIcon || 'ic-add', size: 14, color: 'var(--label-highlight)' })),
              props.primaryLabel)
          : footerButtons(props)),
    ];
  }

  function renderInput(props) {
    // DotsActionSheetInput (variantes cubiertas: main, colors)
    var colors = props.colors || [];
    return [
      titleBlock(props.title, 'ds-action-sheet__title-h6 ds-action-sheet__mt16', 'title'),
      props.icon || props.iconNode
        ? h('div', { key: 'icon', className: 'ds-action-sheet__big-icon', style: props.iconColor ? { color: props.iconColor } : null },
            props.iconNode || icon({ name: props.icon, size: 32, color: 'currentColor' }))
        : null,
      h('div', { key: 'input', className: 'ds-action-sheet__pad16' },
        textField({ hintText: props.inputHint, value: props.inputValue, onChanged: props.onInputChanged, alignCenter: true, maxTextLength: props.maxTextLength })),
      props.inputVariant === 'colors' && colors.length
        ? h('div', { key: 'colors', className: 'ds-action-sheet__colors' },
            colors.map(function (c, i) {
              var sel = i === props.selectedColorIndex;
              return h('span', {
                key: i,
                className: 'ds-action-sheet__color' + (sel ? ' is-selected' : ''),
                style: { background: c },
                role: 'button',
                'aria-pressed': sel,
                onClick: function () { if (props.onColorSelect) props.onColorSelect(i); },
              }, sel ? icon({ name: 'ic-check-thick', size: 16, color: 'var(--label-always-white)' }) : null);
            }))
        : null,
      h('div', { key: 'btns', className: 'ds-action-sheet__pad16 ds-action-sheet__footer ds-action-sheet__mt16' }, footerButtons(props)),
    ];
  }

  function renderRadioButtons(props) {
    // DotsActionSheetRadioButtons: título h5 + subtítulo + RadioCardIcons + botón
    var options = props.options || [];
    return [
      h('div', { key: 'head', className: 'ds-action-sheet__pad16 ds-action-sheet__radio-head' },
        titleBlock(props.title, 'ds-action-sheet__title-h5'),
        props.description ? h('p', { className: 'ds-action-sheet__subtitle' }, props.description) : null),
      h('div', { key: 'opts', className: 'ds-action-sheet__options' },
        options.map(function (opt, i) {
          var isToggle = opt.control === 'toggle';
          var selected = !!opt.selected;
          function handle() { if (props.onSelect) props.onSelect(opt.id != null ? opt.id : i); }
          return h('div', { key: opt.id != null ? opt.id : i, className: 'ds-action-sheet__radio-card' + (selected && !isToggle ? ' is-selected' : ''), onClick: handle },
            h('div', { className: 'ds-action-sheet__radio-card-inner' },
              h('div', { className: 'ds-action-sheet__radio-card-col' },
                h('div', { className: 'ds-action-sheet__radio-line ds-action-sheet__radio-line--title' },
                  opt.titleIcon ? icon({ name: opt.titleIcon, size: 16, color: 'currentColor' }) : null, opt.title),
                (opt.details || []).map(function (d, j) {
                  return h('div', { key: j, className: 'ds-action-sheet__radio-line' },
                    d.icon ? icon({ name: d.icon, size: 16, color: 'currentColor' }) : null, d.label);
                })),
              isToggle
                ? h('span', { className: 'ds-action-sheet__toggle' + (selected ? ' is-on' : ''), role: 'switch', 'aria-checked': selected },
                    h('span', { className: 'ds-action-sheet__toggle-knob' }))
                : radioControl(selected, handle)));
        })),
      h('div', { key: 'btns', className: 'ds-action-sheet__pad16 ds-action-sheet__footer ds-action-sheet__mt20' }, footerButtons(props)),
    ];
  }

  function renderSettings(props) {
    // DotsActionSheetSettings: avatar 100 circular + titleH5 + subtítulo + DotsSystemButtons
    var buttons = props.buttons || [];
    return [
      h('div', { key: 'avatar', className: 'ds-action-sheet__avatar', style: props.image ? { backgroundImage: 'url(' + props.image + ')' } : null }),
      h('div', { key: 'head', className: 'ds-action-sheet__pad16 ds-action-sheet__mt16' },
        titleBlock(props.title, 'ds-action-sheet__settings-title'),
        props.description ? h('p', { className: 'ds-action-sheet__settings-sub' }, props.description) : null),
      h('div', { key: 'btns', className: 'ds-action-sheet__sys-btns' },
        buttons.map(function (b, i) {
          // DotsSystemButton: h44 r16 bgContainerSecondaryOnBackground + blur50
          return h('button', {
            key: i,
            type: 'button',
            className: 'ds-action-sheet__sys-btn' + (b.destructive ? ' is-destructive' : '') + (b.disabled ? ' is-disabled' : ''),
            disabled: !!b.disabled,
            onClick: b.onTap,
          }, b.icon ? icon({ name: b.icon, size: 20, color: 'currentColor' }) : null, b.label);
        })),
    ];
  }

  function renderSearch(props) {
    // DotsActionSheetSearchContent: título h6 (w190) + DotsTextFieldButton + contenido + fade + botón h44
    return [
      titleBlock(props.title, 'ds-action-sheet__title-h6 ds-action-sheet__search-title', 'title'),
      h('div', { key: 'search', className: 'ds-action-sheet__pad16 ds-action-sheet__search-row' },
        textField({ icon: props.searchIcon || 'ic-search', hintText: props.searchHint, value: props.searchValue, onChanged: props.onSearchChanged })),
      h('div', { key: 'list', className: 'ds-action-sheet__list' },
        props.children || (props.items || []).map(function (it, i) { return h(ListItem, Object.assign({ key: i }, it)); })),
      props.primaryLabel != null || props.primaryButton
        ? h('div', { key: 'fade', className: 'ds-action-sheet__fade-footer' },
            props.primaryButton || mainButton({ label: props.primaryLabel, variant: 'main', size: 'large', expand: false, enabled: props.primaryEnabled !== false, onClick: props.onPrimaryTap }))
        : null,
    ];
  }

  function renderSpotlight(props) {
    // DotsActionSheetSpotlight: imagen + título h6 + label + descripción + botón
    return [
      h('div', { key: 'img', className: 'ds-action-sheet__pad16 ds-action-sheet__mt16' },
        h('div', { className: 'ds-action-sheet__spot-img', style: props.image ? { backgroundImage: 'url(' + props.image + ')' } : null })),
      h('div', { key: 'head', className: 'ds-action-sheet__pad16 ds-action-sheet__mt20' },
        titleBlock(props.title, 'ds-action-sheet__title-h6'),
        props.label ? h('p', { className: 'ds-action-sheet__spot-label' }, props.label) : null,
        props.description ? h('p', { className: 'ds-action-sheet__spot-desc' }, props.description) : null),
      h('div', { key: 'btns', className: 'ds-action-sheet__pad16 ds-action-sheet__spot-footer' }, footerButtons(props)),
    ];
  }

  function DotsActionSheet(props) {
    var variant = props.variant || 'standard';
    // Grabber: por defecto en todas menos search (Dart: SearchContent no lo pinta)
    var showGrabber = props.showGrabber != null ? !!props.showGrabber : variant !== 'search';

    var body;
    var closeTop = null;
    switch (variant) {
      case 'list': body = renderList(props); break;
      case 'input': body = renderInput(props); break;
      case 'radioButtons': body = renderRadioButtons(props); closeTop = 12; break;
      case 'settings': body = renderSettings(props); break;
      case 'search': body = renderSearch(props); break;
      case 'spotlight': body = renderSpotlight(props); closeTop = 12; break;
      default: variant = 'standard'; body = renderStandard(props);
    }

    return h(
      'div',
      { className: 'ds-action-sheet ds-action-sheet--' + variant + (props.className ? ' ' + props.className : ''), style: props.style },
      showGrabber ? grabber() : null,
      body,
      props.showCloseButton ? closeButton(props, closeTop) : null
    );
  }

  DotsActionSheet.ListItem = ListItem;
  return DotsActionSheet;
})();
