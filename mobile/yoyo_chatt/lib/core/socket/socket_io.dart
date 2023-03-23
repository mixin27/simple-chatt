import 'package:socket_io_client/socket_io_client.dart';
import 'package:yoyo_chatt/core/utils/endpoints.dart';
import 'package:yoyo_chatt/core/utils/logger.dart';

class SocketIo {
  static SocketIo? _singleton;

  static late Socket _socket;

  SocketIo._() {
    dLog("Constructing SocketIO client...");
    _socket = createSocketIOClient();
  }

  factory SocketIo.init() {
    _singleton ??= SocketIo._();

    return _singleton!;
  }

  static Socket get instance => _socket;

  static String get socketId => _socket.id ?? '11111.11111111';
}

Socket createSocketIOClient() {
  dLog('SocketIO client created.');
  return io(
    Endpoints.socketUrl,
    OptionBuilder().setTransports(['websocket']).build(),
  );
}
