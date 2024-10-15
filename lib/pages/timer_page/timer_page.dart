import 'package:flutter/material.dart';
import 'package:minimalist_state_timer_app/pages/timer_page/timer_page_logic.dart';
import 'package:minimalist_state_timer_app/services/service_locator.dart';

class TimerPage extends StatefulWidget {
  const TimerPage({super.key});

  @override
  State<TimerPage> createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  final stateManagement = getIt<TimerPageManager>();

  @override
  void initState() {
    stateManagement.initiTimerState();
    super.initState();
  }

  @override
  void dispose() {
    stateManagement.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('building MyHomePage');
    return Scaffold(
      appBar: AppBar(title: const Text('My Timer App')),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TimerTextWidget(),
            SizedBox(height: 20),
            ButtonsContainer(),
          ],
        ),
      ),
    );
  }
}

class TimerTextWidget extends StatelessWidget {
  const TimerTextWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final stateManager = getIt<TimerPageManager>();
    return ValueListenableBuilder(
      valueListenable: stateManager.timeLeftNotifier,
      builder: (context, timeLeft, _) {
        debugPrint('building time left state: $timeLeft');
        return Text(
          timeLeft,
          style: Theme.of(context).textTheme.displayMedium,
        );
      },
    );
  }
}

class ButtonsContainer extends StatelessWidget {
  const ButtonsContainer({super.key});

  @override
  Widget build(BuildContext context) {
    final stateManager = getIt<TimerPageManager>();
    // TODO: extract to a new file, i.e. see time_left_notifier
    return ValueListenableBuilder(
      valueListenable: stateManager.buttonNotifier,
      builder: (_, buttonState, __) {
        debugPrint('building button state: $buttonState');
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (buttonState == ButtonState.initial) ...[
              const StartButton(),
            ],
            if (buttonState == ButtonState.started) ...[
              const PauseButton(),
              const SizedBox(width: 20),
              const ResetButton(),
            ],
            if (buttonState == ButtonState.paused) ...[
              const StartButton(),
              const SizedBox(width: 20),
              const ResetButton(),
            ],
            if (buttonState == ButtonState.finished) ...[
              const ResetButton(),
            ],
          ],
        );
      },
    );
  }
}

class StartButton extends StatelessWidget {
  const StartButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        final stateManager = getIt<TimerPageManager>();
        stateManager.start();
      },
      child: const Icon(Icons.play_arrow),
    );
  }
}

class PauseButton extends StatelessWidget {
  const PauseButton({super.key});
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        final stateManager = getIt<TimerPageManager>();
        stateManager.pause();
      },
      child: const Icon(Icons.pause),
    );
  }
}

class ResetButton extends StatelessWidget {
  const ResetButton({super.key});
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        final stateManager = getIt<TimerPageManager>();
        stateManager.reset();
      },
      child: const Icon(Icons.replay),
    );
  }
}
