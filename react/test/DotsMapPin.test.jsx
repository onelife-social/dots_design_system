import assert from 'node:assert/strict';
import { test } from 'node:test';
import { renderToStaticMarkup } from 'react-dom/server';
import { DotsMapPin } from '../src/components/DotsMapPin/DotsMapPin';

const svgOf = (markup) => markup.match(/<svg[^>]*>/)[0];

test('two markers on one map do not share their filter and gradient ids', () => {
  const markup = renderToStaticMarkup(
    <div>
      <DotsMapPin />
      <DotsMapPin />
    </div>,
  );
  const ids = [...markup.matchAll(/ id="([^"]+)"/g)].map((m) => m[1]);

  assert.equal(ids.length, 6);
  assert.equal(new Set(ids).size, 6);
  for (const id of ids) assert.match(markup, new RegExp(`url\\(#${id}\\)`), id);
});

test('ariaLabel names the marker', () => {
  const svg = svgOf(renderToStaticMarkup(<DotsMapPin ariaLabel="Finca El Olivar" />));

  assert.match(svg, / role="img"/);
  assert.match(svg, / aria-label="Finca El Olivar"/);
  assert.doesNotMatch(svg, / aria-hidden=/);
});

test('without ariaLabel, or with an empty one, the marker is decorative', () => {
  for (const ariaLabel of [undefined, '']) {
    const svg = svgOf(renderToStaticMarkup(<DotsMapPin ariaLabel={ariaLabel} />));

    assert.match(svg, / aria-hidden="true"/, `ariaLabel: ${ariaLabel}`);
    assert.doesNotMatch(svg, / role=/, `ariaLabel: ${ariaLabel}`);
  }
});
