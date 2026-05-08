import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../models/work_model.dart';
import '../providers/auth_provider.dart';
import '../providers/work_provider.dart';
import 'package:flutter_animate/flutter_animate.dart';

class WorksScreen extends StatefulWidget {
  const WorksScreen({super.key});

  @override
  State<WorksScreen> createState() => _WorksScreenState();
}

class _WorksScreenState extends State<WorksScreen> {
  final picker = ImagePicker();

  final descriptionController = TextEditingController();

  File? image;

  Future<void> pickImage(ImageSource source) async {
    final picked = await picker.pickImage(source: source);

    if (picked != null) {
      setState(() {
        image = File(picked.path);
      });
    }
  }

  void saveWork() {
    if (image == null || descriptionController.text.isEmpty) {
      return;
    }

    final work = WorkModel(
      imagePath: image!.path,
      description: descriptionController.text,
    );

    Provider.of<WorkProvider>(context, listen: false).addWork(work);

    setState(() {
      image = null;
    });

    descriptionController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);

    final provider = Provider.of<WorkProvider>(context);

    return Scaffold(
      backgroundColor: const Color(0xFF0D0D0D),

      appBar: AppBar(title: const Text("Cortes")),

      body: Padding(
        padding: const EdgeInsets.all(15),

        child: Column(
          children: [
            // SOLO ADMIN
            if (auth.isAdmin) ...[
              if (image != null)
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),

                  child: Image.file(
                    image!,
                    height: 180,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),

              const SizedBox(height: 15),

              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.photo),

                      label: const Text("Galería"),

                      onPressed: () {
                        pickImage(ImageSource.gallery);
                      },
                    ),
                  ),

                  const SizedBox(width: 10),

                  Expanded(
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.camera_alt),

                      label: const Text("Cámara"),

                      onPressed: () {
                        pickImage(ImageSource.camera);
                      },
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 15),

              TextField(
                controller: descriptionController,

                decoration: const InputDecoration(labelText: "Descripción"),
              ),

              const SizedBox(height: 15),

              ElevatedButton(
                onPressed: saveWork,

                child: const Text("Publicar Corte"),
              ),

              const SizedBox(height: 20),
            ],

            // GALERÍA
            Expanded(
              child: ListView.builder(
                itemCount: provider.works.length,

                itemBuilder: (context, index) {
                  final work = provider.works[index];

                  return Container(
                        margin: const EdgeInsets.only(bottom: 25),

                        decoration: BoxDecoration(
                          color: const Color(0xFF1A1A1A),

                          borderRadius: BorderRadius.circular(25),

                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.35),
                              blurRadius: 15,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),

                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,

                          children: [
                            // IMAGEN
                            ClipRRect(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(25),
                                topRight: Radius.circular(25),
                              ),

                              child: GestureDetector(
                                onTap: () {
                                  showDialog(
                                    context: context,

                                    builder: (_) {
                                      return Dialog(
                                        backgroundColor: Colors.transparent,

                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                            25,
                                          ),

                                          child: Image.file(
                                            File(work.imagePath),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },

                                child: Hero(
                                  tag: work.imagePath,

                                  child: Image.file(
                                    File(work.imagePath),

                                    height: 260,

                                    width: double.infinity,

                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),

                            // DESCRIPCIÓN
                            Padding(
                              padding: const EdgeInsets.all(18),

                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,

                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 12,
                                          vertical: 6,
                                        ),

                                        decoration: BoxDecoration(
                                          color: const Color(0xFF7B1113),

                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),
                                        ),

                                        child: const Text(
                                          "Barber YS",

                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),

                                      const Spacer(),

                                      if (auth.isAdmin)
                                        IconButton(
                                          icon: const Icon(
                                            Icons.delete,
                                            color: Colors.red,
                                          ),

                                          onPressed: () {
                                            provider.removeWork(index);
                                          },
                                        ),
                                    ],
                                  ),

                                  const SizedBox(height: 12),

                                  Text(
                                    work.description,

                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 17,
                                      height: 1.5,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                      .animate()
                      .fade(duration: 500.ms)
                      .slideY(begin: 0.2, end: 0, duration: 500.ms);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
