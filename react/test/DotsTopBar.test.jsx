import assert from 'node:assert/strict';
import { test } from 'node:test';
import { renderToStaticMarkup } from 'react-dom/server';
import { DotsTopBar } from '../src/components/DotsTopBar/DotsTopBar';

test('backAriaLabel names the back button', () => {
  const markup = renderToStaticMarkup(<DotsTopBar title="Las preguntas" onBack={() => {}} backAriaLabel="Atrás" />);

  assert.match(markup, /<button[^>]*aria-label="Atrás"/);
});

test('without backAriaLabel the back button has no made-up name', () => {
  const markup = renderToStaticMarkup(<DotsTopBar title="Las preguntas" onBack={() => {}} />);

  assert.doesNotMatch(markup, /<button[^>]*aria-label/);
});

const GRADIENT = /class="ds-top-bar__gradient"/;

test('showGradient with hideBackground paints the gradient layer, hidden from the screen reader', () => {
  const markup = renderToStaticMarkup(<DotsTopBar onBack={() => {}} title="Elige qué crear" hideBackground showGradient />);

  assert.match(markup, /<span class="ds-top-bar__gradient" aria-hidden="true"><\/span>/);
});

test('no gradient without showGradient, with a background, with a color or with only the status bar', () => {
  for (const props of [
    { title: 'Elige qué crear', hideBackground: true },
    { title: 'Elige qué crear', showGradient: true },
    { title: 'Elige qué crear', hideBackground: true, showGradient: true, color: 'var(--bg-base)' },
    { variant: 'onlyStatusBar', hideBackground: true, showGradient: true },
  ]) {
    assert.doesNotMatch(renderToStaticMarkup(<DotsTopBar {...props} />), GRADIENT, JSON.stringify(props));
  }
});
