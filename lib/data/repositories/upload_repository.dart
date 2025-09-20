import 'package:rockwolf_test/data/services/upload_service.dart';

abstract class IUploadRepository {
  Future<void> uploadPhotos(String path);
}

class UploadRepository implements IUploadRepository {
  final UploadService _service;

  UploadRepository(this._service);

  @override
  Future<void> uploadPhotos(String path) {
    return _service.upload(path);
  }
}
