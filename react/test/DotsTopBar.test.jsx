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
