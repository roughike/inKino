import 'dart:async';
import 'dart:html' as html;

import 'package:angular/angular.dart';
import 'package:core/core.dart';
import 'package:web/src/common/loading_view/spinner_component.dart';

@Component(
  selector: 'loading-view',
  templateUrl: 'loading_view_component.html',
  styleUrls: ['loading_view_component.css'],
  directives: [
    SpinnerComponent,
    NgIf,
  ],
)
class LoadingViewComponent implements OnDestroy {
  LoadingViewComponent(this.messages);
  final Messages messages;

  LoadingStatus _status;

  @Input()
  bool contentEmpty = false;

  @Input()
  String errorTitle;

  @Input()
  String errorMessage;

  String get emptyTitle => contentEmpty ? messages.allEmpty : null;
  String get emptyMessage => contentEmpty ? messages.noMoviesForToday : null;

  @Output()
  Stream get actionButtonClicked => _tryAgainController.stream;
  final _tryAgainController = StreamController();

  @Input()
  set status(LoadingStatus status) {
    _clearOutInvisibleContent = false;
    _status = status;

    Timer(
      const Duration(milliseconds: 450),
      () => _clearOutInvisibleContent = true,
    );
  }

  bool get loadingContentVisible => _status == LoadingStatus.loading;
  bool get loadingContentPresent =>
      loadingContentVisible || !_clearOutInvisibleContent;

  bool get successContentVisible => _status == LoadingStatus.success;
  bool get successContentPresent =>
      successContentVisible || !_clearOutInvisibleContent;

  bool get errorContentVisible =>
      _status == LoadingStatus.error ||
      (_status != LoadingStatus.loading && contentEmpty);
  bool get errorContentPresent =>
      errorContentVisible || !_clearOutInvisibleContent;

  // After animations have finished, all invisible content gets removed from DOM.
  bool _clearOutInvisibleContent = false;

  void onTryAgainClicked(html.Event event) {
    event.preventDefault();
    _tryAgainController.add(null);
  }

  @override
  void ngOnDestroy() => _tryAgainController.close();
}
