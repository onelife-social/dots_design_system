import assert from 'node:assert/strict';
import { test } from 'node:test';
import { renderToStaticMarkup } from 'react-dom/server';
import { DotsAlert } from '../src/components/DotsAlert/DotsAlert';

const dialogOf = (element) => renderToStaticMarkup(element).match(/<div[^>]*role="alertdialog"[^>]*>/)[0];

test('with showScrim the alert declares itself modal', () => {
  const dialog = dialogOf(<DotsAlert title="¿Quitar esta pregunta?" showScrim />);

  assert.match(dialog, / aria-modal="true"/);
  assert.match(dialog, / aria-label="¿Quitar esta pregunta\?"/);
});

test('the bare card is not modal', () => {
  const dialog = dialogOf(<DotsAlert title="¿Quitar esta pregunta?" />);

  assert.doesNotMatch(dialog, / aria-modal=/);
});
