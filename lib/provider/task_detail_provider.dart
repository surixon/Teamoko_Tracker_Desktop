
import 'package:desk/provider/base_provider.dart';

class TaskDetailProvider extends BaseProvider{


/*  Future<Data> getTaskDetail(
      BuildContext context,
      String eventId,
      String companyId,
      String userId) async {
    setState(ViewState.Busy);
    try {
      var data = await apiClient.getTaskDetail(
          eventId, companyId, userId);
      if (data.response.status == "1") {
        setState(ViewState.Idle);
        return data.response.data[0];
      } else {
        DialogHelper.showMessage(context, data.response.message);
        setState(ViewState.Idle);
        return null;
      }
    } on FetchDataException catch (c) {
      DialogHelper.showMessage(context, c.toString());
      setState(ViewState.Idle);
      return null;
    } on SocketException {
      DialogHelper.showMessage(context, StringConstants.no_internet);
      setState(ViewState.Idle);
      return null;
    }
  }*/
}