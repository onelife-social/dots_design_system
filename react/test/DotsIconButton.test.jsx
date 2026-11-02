import assert from 'node:assert/strict';
import { test } from 'node:test';
import { renderToStaticMarkup } from 'react-dom/server';
import { DotsIconButton } from '../src/components/DotsIconButton/DotsIconButton';

test('variant floating paints what style floating paints', () => {
  const viaVariant = renderToStaticMarkup(<DotsIconButton icon="ic-pencil" size="large" variant="floating" iconSize={20} />);
  const viaStyle = renderToStaticMarkup(<DotsIconButton icon="ic-pencil" size="large" style="floating" iconSize={20} />);

  assert.equal(viaVariant, viaStyle);
  assert.match(viaVariant, /ds-icon-btn__circle--floating-default/);
});

test('style and state win over variant floating', () => {
  const markup = renderToStaticMarkup(<DotsIconButton icon="ic-pencil" variant="floating" style="onPhoto" />);

  assert.match(markup, /ds-icon-btn__circle--photo-default/);
  assert.doesNotMatch(markup, /floating/);
});

test('ariaLabel names the button', () => {
  const markup = renderToStaticMarkup(<DotsIconButton icon="ic-trash" ariaLabel="Quitar" onClick={() => {}} />);

  assert.match(markup, /<button[^>]*aria-label="Quitar"/);
});

test('without ariaLabel the button has no made-up name', () => {
  const markup = renderToStaticMarkup(<DotsIconButton icon="ic-trash" onClick={() => {}} />);

  assert.doesNotMatch(markup, /<button[^>]*aria-label/);
});

test('without onClick the circle stays hidden from the screen reader, whatever ariaLabel says', () => {
  const markup = renderToStaticMarkup(<DotsIconButton icon="ic-pencil" ariaLabel="Editar" />);

  assert.doesNotMatch(markup, /aria-label="Editar"/);
  assert.match(markup, /aria-hidden="true"/);
});
