// @dart=2.9
import 'package:desk/utils/constants.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;


class SocketIoManager {

  IO.Socket socket;
  SocketIoManager();

  Future<void> connectSocket() async {
    socket = IO.io(socketUrl,IO.OptionBuilder()
        .setTransports(['websocket'])
        .enableAutoConnect()
        .enableReconnection()
        .build());
    socket.connect();

    socket.onConnect((_) {
      print('connect');
    });

    socket.onDisconnect((_) => print('disconnect'));
    socket.onConnectError((_) => print('connect error'));
  }


}
