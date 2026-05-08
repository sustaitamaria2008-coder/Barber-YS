import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class GalleryScreen extends StatefulWidget {
  const GalleryScreen({super.key});

  @override
  State<GalleryScreen> createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  final ImagePicker picker = ImagePicker();
  final List<File> images = [];

  Future<void> pickFromGallery() async {
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        images.add(File(image.path));
      });
    }
  }

  Future<void> takePhoto() async {
    final XFile? image = await picker.pickImage(source: ImageSource.camera);

    if (image != null) {
      setState(() {
        images.add(File(image.path));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Galería de Trabajos"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton.icon(
                icon: const Icon(Icons.photo),
                label: const Text("Galería"),
                onPressed: pickFromGallery,
              ),
              ElevatedButton.icon(
                icon: const Icon(Icons.camera_alt),
                label: const Text("Cámara"),
                onPressed: takePhoto,
              ),
            ],
          ),

          const SizedBox(height: 20),

          Expanded(
            child: images.isEmpty
                ? const Center(child: Text("No hay fotos todavía"))
                : GridView.builder(
                    padding: const EdgeInsets.all(10),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                        ),
                    itemCount: images.length,
                    itemBuilder: (context, index) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.file(images[index], fit: BoxFit.cover),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
