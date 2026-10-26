// DotsTimePicker — inline hour/minute wheel, 24 h. New in the web DS (no Dart widget): the Flutter app picks
// times with CupertinoDatePicker in time mode inside CupertinoDatePickerPopupStyle (onelife_app). Both
// columns loop like that wheel; rows and band look like the DotsCalendar month/year picker.
import { useEffect, useMemo, useRef, useState } from 'react';
import { WheelColumn } from '../../internal/WheelColumn';

export interface DotsTimePickerProps {
  /** Selected time as HH:mm, 24 h (controlled); '' or undefined shows the device's current time without reporting it */
  value?: string;
  /** Called with the new time as HH:mm whenever another row passes under the band, a row is tapped or an arrow key moves it */
  onChange?: (time: string) => void;
  /** Step of the minutes column, a divisor of 60 (default 1); a value off the step shows the step below it */
  minuteInterval?: number;
  /** Accessible names of the columns (default 'Hours' / 'Minutes') */
  hoursLabel?: string;
  minutesLabel?: string;
  className?: string;
}

const pad = (n: number) => String(n).padStart(2, '0');
const parseTime = (time?: string): [number, number] | null => {
  const m = /^(\d{2}):(\d{2})/.exec(time ?? '');
  if (!m) return null;
  const h = Number(m[1]);
  const min = Number(m[2]);
  return h < 24 && min < 60 ? [h, min] : null;
};
const now = (): [number, number] => {
  const d = new Date();
  return [d.getHours(), d.getMinutes()];
};

const HOURS = Array.from({ length: 24 }, (_, h) => pad(h));

export function DotsTimePicker(props: DotsTimePickerProps) {
  const step = props.minuteInterval && props.minuteInterval > 0 && 60 % props.minuteInterval === 0 ? props.minuteInterval : 1;
  const minutes = useMemo(() => Array.from({ length: 60 / step }, (_, i) => pad(i * step)), [step]);

  // Mirrors `value`, so the wheel also holds a pick when the parent does not feed it back. The ref is what the
  // columns read: both can report before a render (two fingers), and each must keep the other's latest value.
  const [time, setTime] = useState<[number, number]>(() => parseTime(props.value) ?? now());
  const timeRef = useRef(time);
  useEffect(() => {
    const parsed = parseTime(props.value);
    if (!parsed) return;
    timeRef.current = parsed;
    setTime(parsed);
  }, [props.value]);

  const [hour, minute] = time;
  const pick = (h: number, min: number) => {
    timeRef.current = [h, min];
    setTime([h, min]);
    props.onChange?.(`${pad(h)}:${pad(min)}`);
  };

  return (
    <div className={`ds-time-picker${props.className ? ` ${props.className}` : ''}`}>
      <div className="ds-time-picker__band" aria-hidden />
      <WheelColumn
        items={HOURS}
        index={hour}
        onIndexChange={(h) => pick(h, timeRef.current[1] - (timeRef.current[1] % step))}
        ariaLabel={props.hoursLabel ?? 'Hours'}
        loop
        {...wheelClasses}
      />
      <WheelColumn
        items={minutes}
        index={Math.floor(minute / step)}
        onIndexChange={(i) => pick(timeRef.current[0], i * step)}
        ariaLabel={props.minutesLabel ?? 'Minutes'}
        loop
        {...wheelClasses}
      />
    </div>
  );
}

const wheelClasses = { className: 'ds-time-picker__col', itemClassName: 'ds-time-picker__item', selectedItemClassName: 'ds-time-picker__item--selected' };
