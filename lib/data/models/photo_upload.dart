enum UploadStatus { pending, loading, success, error }

class PhotoUploadDTO {
  final String path;
  UploadStatus status;

  PhotoUploadDTO copyWith({UploadStatus? status}) {
    return PhotoUploadDTO(path: path, status: status ?? this.status);
  }

  PhotoUploadDTO({required this.path, required this.status});
}
