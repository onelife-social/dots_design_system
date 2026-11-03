import assert from 'node:assert/strict';
import { test } from 'node:test';
import { renderToStaticMarkup } from 'react-dom/server';
import { DotsActionSheet } from '../src/components/DotsActionSheet/DotsActionSheet';

const rootOf = (element) => renderToStaticMarkup(element).match(/<div[^>]*>/)[0];

test('the sheet is a modal dialog named by its title', () => {
  for (const variant of ['standard', 'list', 'input', 'search']) {
    const root = rootOf(<DotsActionSheet variant={variant} title="Sin teléfono" />);

    assert.match(root, / role="dialog"/, variant);
    assert.match(root, / aria-modal="true"/, variant);
    assert.match(root, / aria-label="Sin teléfono"/, variant);
  }
});

test('without a title the dialog has no made-up name', () => {
  const root = rootOf(<DotsActionSheet />);

  assert.match(root, / role="dialog"/);
  assert.doesNotMatch(root, / aria-label=/);
});
