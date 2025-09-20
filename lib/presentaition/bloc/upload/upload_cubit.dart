import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rockwolf_test/data/models/photo_upload.dart';
import 'package:rockwolf_test/domain/usecases/upload_photo_usecase.dart';
import 'package:rockwolf_test/presentaition/bloc/upload/upload_state.dart';

class UploadCubit extends Cubit<UploadState> {
  final UploadPhotoUseCase _uploadPhoto;

  UploadCubit(this._uploadPhoto) : super(const UploadState());

  // mocked value as tecnical task requirements
  final int _photosQuantity = 5;

  void addPhotos(List<String> paths) {
    final currentPhotos = List<PhotoUploadDTO>.from(state.photos);
    final newPhotos = paths
        .take(_photosQuantity - currentPhotos.length)
        .map(
          (path) => PhotoUploadDTO(path: path, status: UploadStatus.pending),
        );

    emit(state.copyWith(photos: [...currentPhotos, ...newPhotos]));
  }

  Future<void> startUploadPhoto() async {
    if (state.isLoading) return;

    emit(state.copyWith(isLoading: true, currentIndex: 0));

    for (var i = 0; i < state.photos.length; i++) {
      final currentPhoto = state.photos[i];

      if (currentPhoto.status == UploadStatus.success) continue;

      _updatePhoto(i, UploadStatus.loading);
      emit(state.copyWith(currentIndex: i + 1));

      try {
        await _uploadPhoto(currentPhoto.path);
        _updatePhoto(i, UploadStatus.success);
      } catch (e) {
        _updatePhoto(i, UploadStatus.error);
      }
    }
    emit(state.copyWith(isLoading: false));
  }

  void retryUploadPhoto() {
    final updatedPhotos = state.photos.map((photo) {
      if (photo.status == UploadStatus.error) {
        return photo.copyWith(status: UploadStatus.loading);
      }
      return photo;
    }).toList();

    emit(state.copyWith(photos: updatedPhotos));
    startUploadPhoto();
  }

  void _updatePhoto(int index, UploadStatus status) {
    final updatedPhotos = List<PhotoUploadDTO>.from(state.photos);
    updatedPhotos[index] = updatedPhotos[index].copyWith(status: status);

    emit(state.copyWith(photos: updatedPhotos));
  }
}
