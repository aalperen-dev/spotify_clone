import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spotify/core/theme/app_palette.dart';
import 'package:spotify/core/utilities/utilities.dart';
import 'package:spotify/core/widgets/app_loader.dart';
import 'package:spotify/core/widgets/custom_textformfield.dart';
import 'package:spotify/features/home/view/widgets/audio_wave.dart';
import 'package:spotify/features/home/viewmodel/home_viewmodel.dart';

class UploadSongPage extends ConsumerStatefulWidget {
  const UploadSongPage({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _UploadSongPageState();
}

class _UploadSongPageState extends ConsumerState<UploadSongPage> {
  final TextEditingController songNameController = TextEditingController();
  final TextEditingController artistController = TextEditingController();
  Color selectedColor = Pallete.cardColor;
  File? selectedAudio;
  File? selectedImage;
  final formKey = GlobalKey<FormState>();
  void selectAudio() async {
    final pickedAudio = await AppUtilities.pickAudio();

    if (pickedAudio != null) {
      setState(() {
        selectedAudio = pickedAudio;
      });
    }
  }

  void selectImage() async {
    final pickedImage = await AppUtilities.pickImage();

    if (pickedImage != null) {
      setState(() {
        selectedImage = pickedImage;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    songNameController.dispose();
    artistController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(homeViewModelProvider.select(
      (value) => value?.isLoading == true,
    ));
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload Song'),
        actions: [
          IconButton(
            onPressed: () {
              if (formKey.currentState!.validate() &&
                  selectedAudio != null &&
                  selectedImage != null) {
                ref.read(homeViewModelProvider.notifier).uploadSong(
                      selectedAudio: selectedAudio!,
                      selectedThumbnail: selectedImage!,
                      songName: songNameController.text,
                      artist: artistController.text,
                      selectedColor: selectedColor,
                    );
              } else {
                AppUtilities.showSnackBar(
                    context: context, content: 'Missing Fields!');
              }
            },
            icon: const Icon(Icons.check),
          ),
        ],
      ),
      body: isLoading
          ? const AppLoader()
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: selectImage,
                        child: selectedImage != null
                            ? SizedBox(
                                height: 150,
                                width: double.infinity,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.file(
                                    selectedImage!,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              )
                            : DottedBorder(
                                radius: const Radius.circular(10),
                                borderType: BorderType.RRect,
                                strokeCap: StrokeCap.round,
                                color: Pallete.borderColor,
                                dashPattern: const [10, 4],
                                child: const SizedBox(
                                  width: double.infinity,
                                  height: 150,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.folder_open,
                                      ),
                                      SizedBox(height: 15),
                                      Text(
                                        'Select the thumbnail for your song.',
                                        style: TextStyle(fontSize: 15),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                      ),
                      //
                      const SizedBox(height: 40),
                      //
                      selectedAudio != null
                          ? AudioWave(path: selectedAudio!.path)
                          : CustomTextFormField(
                              onTap: selectAudio,
                              hintText: 'Pick song.',
                              controller: null,
                              isReadOnly: true,
                            ),
                      //
                      const SizedBox(height: 20),
                      //
                      CustomTextFormField(
                        hintText: 'Artist.',
                        controller: artistController,
                      ),
                      //
                      const SizedBox(height: 20),
                      //
                      CustomTextFormField(
                        hintText: 'Song name.',
                        controller: songNameController,
                      ),
                      //
                      const SizedBox(height: 20),
                      //
                      ColorPicker(
                        pickersEnabled: const {
                          ColorPickerType.wheel: true,
                        },
                        color: selectedColor,
                        onColorChanged: (color) {
                          setState(() {
                            selectedColor = color;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
