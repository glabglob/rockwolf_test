import 'package:equatable/equatable.dart';
import 'package:rockwolf_test/data/models/photo_upload.dart';

class UploadState extends Equatable {
  final List<PhotoUploadDTO> photos;
  final bool isLoading;
  final int currentIndex;

  const UploadState({
    this.photos = const [],
    this.isLoading = false,
    this.currentIndex = 0,
  });

  UploadState copyWith({
    List<PhotoUploadDTO>? photos,
    bool? isLoading,
    int? currentIndex,
  }) {
    return UploadState(
      photos: photos ?? this.photos,
      isLoading: isLoading ?? this.isLoading,
      currentIndex: currentIndex ?? this.currentIndex,
    );
  }

  @override
  List<Object?> get props => [photos, isLoading, currentIndex];
}
