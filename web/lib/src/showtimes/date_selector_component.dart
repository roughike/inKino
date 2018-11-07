import 'package:angular/angular.dart';

@Component(
  selector: 'date-selector',
  styleUrls: ['date_selector_component.css'],
  templateUrl: 'date_selector_component.html',
  directives: [NgFor],
  pipes: [DatePipe],
)
class DateSelectorComponent {
  @Input()
  List<DateTime> dates;

  @Input()
  DateTime selectedDate;

  @Input()
  Function(DateTime) newDateSelected;
}
