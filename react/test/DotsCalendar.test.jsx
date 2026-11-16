import assert from 'node:assert/strict';
import { test } from 'node:test';
import { renderToStaticMarkup } from 'react-dom/server';
import { DotsCalendar } from '../src/components/DotsCalendar/DotsCalendar';

const base = { today: '2026-11-16', locale: 'es' };

test('the month arrows carry the names the app passes', () => {
  const markup = renderToStaticMarkup(<DotsCalendar {...base} previousMonthLabel="Mes anterior" nextMonthLabel="Mes siguiente" />);

  assert.match(markup, /<button[^>]*aria-label="Mes anterior"/);
  assert.match(markup, /<button[^>]*aria-label="Mes siguiente"/);
  assert.ok(markup.indexOf('Mes anterior') < markup.indexOf('Mes siguiente'));
});

test('without labels the arrows get no made-up name', () => {
  const markup = renderToStaticMarkup(<DotsCalendar {...base} />);
  const header = markup.slice(0, markup.indexOf('ds-calendar__grid'));

  assert.doesNotMatch(header, /ds-icon-btn[^>]*aria-label|<button[^>]*aria-label/);
});

test('the month and year wheels carry the names the app passes', () => {
  const markup = renderToStaticMarkup(<DotsCalendar {...base} initialPicking monthWheelLabel="Mes" yearWheelLabel="Año" />);

  assert.match(markup, /role="listbox" aria-label="Mes"/);
  assert.match(markup, /role="listbox" aria-label="Año"/);
});

test('without labels the wheels keep their previous names', () => {
  const markup = renderToStaticMarkup(<DotsCalendar {...base} initialPicking />);

  assert.match(markup, /role="listbox" aria-label="month"/);
  assert.match(markup, /role="listbox" aria-label="year"/);
});
