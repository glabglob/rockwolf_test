import 'package:rockwolf_test/data/repositories/upload_repository.dart';

class UploadPhotoUseCase {
  final IUploadRepository repository;

  UploadPhotoUseCase(this.repository);

  Future<void> call(String path) async {
    return repository.uploadPhotos(path);
  }
}
