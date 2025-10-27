import 'package:dots_design_system/dots_design_system.dart';
import 'package:example/components/countdown_event_finished_demo_page.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

List<Story> get countdownStories => [
      Story(
        name: 'Countdowns/Recap Countdown',
        builder: (context) => CountdownRecap(
          title: context.knobs.text(label: 'Title', initial: 'Recap Noviembre'),
          description: context.knobs.text(
              label: 'Description',
              initial: 'Para desbloquear este recap, necesitas subir 16 fotos y 4 vídeos.'),
          countdownDate: DateTime.now().add(
            Duration(
                days: context.knobs.sliderInt(label: 'Days', initial: 0, min: 0, max: 99),
                hours: context.knobs.sliderInt(label: 'Hours', initial: 0, min: 0, max: 23),
                minutes: context.knobs.sliderInt(label: 'Minutes', initial: 5, min: 0, max: 59),
                seconds: context.knobs.sliderInt(label: 'Seconds', initial: 0, min: 0, max: 59)),
          ),
          daysLabel: context.knobs.text(label: 'Days Label', initial: 'días'),
          hoursLabel: context.knobs.text(label: 'Hours Label', initial: 'horas'),
          minutesLabel: context.knobs.text(label: 'Minutes Label', initial: 'min.'),
          secondsLabel: context.knobs.text(label: 'Seconds Label', initial: 'seg.'),
        ),
      ),
      Story(
        name: 'Countdowns/Event Finished Countdown',
        description: 'Demo page for Countdown event finished',
        builder: (context) => CountdownEventFinishedDemoPage(
          variant: context.knobs.options<CountdownEventFinishedVariant>(
            label: 'Variant',
            initial: CountdownEventFinishedVariant.big,
            options: CountdownEventFinishedVariant.values
                .map((item) => Option(label: item.name, value: item))
                .toList(),
          ),
          title: context.knobs.text(label: 'Title', initial: 'Felizmente casados!'),
          icon: DotsIconData.weddingRings,
          years: context.knobs.text(label: 'years', initial: '09'),
          months: context.knobs.text(label: 'months', initial: '11'),
          days: context.knobs.text(label: 'days', initial: '23'),
          yearsLabel: context.knobs.text(label: 'Years label', initial: 'Años'),
          monthsLabel: context.knobs.text(label: 'Months label', initial: 'Meses'),
          daysLabel: context.knobs.text(label: 'Days label', initial: 'Días'),
          conjunctionText: context.knobs.text(label: 'Conjunction text', initial: 'y'),
        ),
      ),
    ];
