import 'package:inkino/redux/show/show_actions.dart';
import 'package:inkino/redux/show/show_reducer.dart';
import 'package:inkino/redux/show/show_state.dart';
import 'package:test/test.dart';

void main() {
  group('ShowReducer', () {
    test(
      'when called with ShowDatesUpdatedAction, should update state with 7 days from today',
      () {
        var initialState = ShowState.initial();
        var reducedState = showReducer(
          initialState,
          ShowDatesUpdatedAction(
            <DateTime>[
              DateTime(2018, 1, 1),
              DateTime(2018, 1, 2),
            ],
          ),
        );

        expect(
          reducedState.dates,
          <DateTime>[
            DateTime(2018, 1, 1),
            DateTime(2018, 1, 2),
          ],
        );

        // Should also select the first date in the list
        expect(reducedState.selectedDate, DateTime(2018, 1, 1));
      },
    );
  });
}
