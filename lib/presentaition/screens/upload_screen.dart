import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rockwolf_test/data/repositories/upload_repository.dart';
import 'package:rockwolf_test/data/services/upload_service.dart';
import 'package:rockwolf_test/domain/usecases/upload_photo_usecase.dart';
import 'package:rockwolf_test/presentaition/bloc/upload/upload_cubit.dart';
import 'package:rockwolf_test/presentaition/bloc/upload/upload_state.dart';

class UploadScreen extends StatelessWidget {
  const UploadScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        final service = UploadService();
        final repository = UploadRepository(service);
        final useCase = UploadPhotoUseCase(repository);
        return UploadCubit(useCase);
      },
      child: const _UploadView(),
    );
  }
}

class _UploadView extends StatefulWidget {
  const _UploadView();

  @override
  State<_UploadView> createState() => _UploadViewState();
}

class _UploadViewState extends State<_UploadView> {
  UploadCubit get _cubit => context.read<UploadCubit>();

  Future<void> _pickPhotos() async {
    final picker = ImagePicker();
    final picked = await picker.pickMultiImage();
    if (picked.isNotEmpty) {
      _cubit.addPhotos(picked.map((e) => e.path).toList());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UploadCubit, UploadState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(title: const Text("Photo Uploader")),

          body: SafeArea(
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: state.photos.length < 5 ? _pickPhotos : null,
                  child: const Text("Upload Photos"),
                ),
                if (state.isLoading)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "${state.currentIndex} of ${state.photos.length} photo is uploading...",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                Expanded(
                  child: GridView.builder(
                    padding: const EdgeInsets.all(8),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                        ),
                    itemCount: state.photos.length,
                    itemBuilder: (context, index) {
                      final photo = state.photos[index];
                      return Stack(
                        children: [
                          Positioned.fill(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.file(
                                File(photo.path),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 4,
                            left: 4,
                            right: 4,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 2,
                                horizontal: 4,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.black54,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                photo.status.toString().split('.').last,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: !state.isLoading
                          ? _cubit.startUploadPhoto
                          : null,
                      child: const Text("Start Uploading"),
                    ),
                    ElevatedButton(
                      onPressed: !state.isLoading
                          ? _cubit.retryUploadPhoto
                          : null,
                      child: const Text("Retry Failed"),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
              ],
            ),
          ),
        );
      },
    );
  }
}
