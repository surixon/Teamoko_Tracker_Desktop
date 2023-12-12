import 'package:desk/api/api_client.dart';
import 'package:desk/enum/viewstate.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';



class BaseProvider extends ChangeNotifier {
  ViewState _state = ViewState.Idle;

  ViewState get state => _state;
  ApiClient apiClient = GetIt.instance.get();

  void setState(ViewState viewState) {
    _state = viewState;
    notifyListeners();
  }
}
