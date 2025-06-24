import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'dio_client.dart';

@LazySingleton(as: DioClient)
class DioClientImpl extends DioClient {
  DioClientImpl() : super();

  @override
  Dio get client => super.client;
}
