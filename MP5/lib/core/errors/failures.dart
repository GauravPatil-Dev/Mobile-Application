import 'package:http/http.dart';

abstract class Failure {
  final String errMessage;

  const Failure(this.errMessage);
}

class ServerFailure extends Failure {
  ServerFailure(super.errMessage);

  // Factory constructor to handle http errors
  factory ServerFailure.fromHttpResponse(Response response) {
    if (response.statusCode >= 400 && response.statusCode < 500) {
      return ServerFailure('Client Error: ${response.statusCode}');
    } else if (response.statusCode >= 500) {
      return ServerFailure('Server Error: ${response.statusCode}');
    } else {
      return ServerFailure('Unexpected Error, Please try again!');
    }
  }

  // Static method to handle general network errors
  static ServerFailure fromNetworkError(Object error) {
    if (error.toString().contains('SocketException')) {
      return ServerFailure('No Internet Connection');
    } else {
      return ServerFailure('Unexpected Network Error, Please try again!');
    }
  }
}
