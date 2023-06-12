import 'package:grpc/grpc.dart';
import 'package:users_api/src/femto_generated/femto.pbgrpc.dart';

class FemtoClient {
  FemtoClient({
    required String baseUrl,
    required int port,
    ClientChannel? channel,
  }) {
    _channel = ClientChannel(
      baseUrl,
      port: port,
      options: const ChannelOptions(
        credentials: ChannelCredentials.insecure(),
      ),
    );

    stub = GatewayClient(_channel);
  }

  late final ClientChannel _channel;
  late final GatewayClient stub;

  // make http call
  Future<HTTPResponse> makeHttpCall(
      {required String url,
      required String method,
      required Map<String, String> headers,
      required String body}) async {
    final response = await stub.makeHTTPCall(
        HTTPRequest(url: url, method: method, headers: headers, body: body));
    return response;
  }

  Future<RabbitMQResponse> sendRabbitMQMessage({required String message}) async {
    final response = await stub.sendRabbitMQMessage(RabbitMQRequest(message: message));
    return response;
}

}
