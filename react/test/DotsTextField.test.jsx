import assert from 'node:assert/strict';
import { test } from 'node:test';
import { renderToStaticMarkup } from 'react-dom/server';
import { DotsTextField } from '../src/components/DotsTextField/DotsTextField';

const inputOf = (element) => renderToStaticMarkup(element).match(/<input[^>]*>/)[0];

test('the input takes the accessible name and the keyboard attributes', () => {
  const input = inputOf(
    <DotsTextField
      hintText="Mark & Anna"
      ariaLabel="Los novios"
      autoCorrect={false}
      spellCheck={false}
      autoComplete="off"
      enterKeyHint="search"
    />,
  );

  assert.match(input, / aria-label="Los novios"/i);
  assert.match(input, / autocorrect="off"/i);
  assert.match(input, / spellcheck="false"/i);
  assert.match(input, / autocomplete="off"/i);
  assert.match(input, / enterkeyhint="search"/i);
});

test('autoCorrect and spellCheck turn the browser features back on', () => {
  const input = inputOf(<DotsTextField autoCorrect spellCheck />);

  assert.match(input, / autocorrect="on"/i);
  assert.match(input, / spellcheck="true"/i);
});

test('without the new props the input keeps the browser defaults', () => {
  const input = inputOf(<DotsTextField hintText="Buscar" />);

  for (const attribute of ['aria-label', 'autocorrect', 'spellcheck', 'autocomplete', 'enterkeyhint']) {
    assert.doesNotMatch(input, new RegExp(` ${attribute}=`, 'i'), attribute);
  }
});
