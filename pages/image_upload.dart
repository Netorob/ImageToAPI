import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class ImageUpload extends StatefulWidget {
  @override
  State<ImageUpload> createState() => _ImageUploadState();
}

class _ImageUploadState extends State<ImageUpload> {
  File? picture;
  final _picker = ImagePicker();
  bool showSpinner = false;

  void _showSuccessMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Imagem enviada com sucesso'),
        backgroundColor: Colors.green,
      ),
    );
  }

  Future<void> uploadImage() async {
    setState(() {
      showSpinner = true;
    });

    if (picture != null) {
      var stream = http.ByteStream(picture!.openRead());
      var length = await picture!.length();
      var uri = Uri.parse('https://fakestoreapi.com/products');
      var request = http.MultipartRequest('POST', uri);

      request.fields['title'] = "Static title";
      var multipartFile = http.MultipartFile('image', stream, length);

      request.files.add(multipartFile);

      var response = await request.send();

      if (response.statusCode == 200) {
        _showSuccessMessage(); // Exibe a mensagem de sucesso
      } else {
        print('Erro ao enviar imagem');
      }
    } else {
      print('Nenhuma imagem selecionada');
    }

    setState(() {
      showSpinner = false;
    });
  }

  Future<void> getImage() async {
    final pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );

    if (pickedFile != null) {
      setState(() {
        picture = File(pickedFile.path);
      });
    } else {
      print('Nenhuma imagem selecionada');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Selecionar Imagem'),
          centerTitle: true, // Centralizar o título da AppBar
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: getImage,
                child: Container(
                  width: 100,
                  height: 100,
                  color: Colors.grey[300],
                  child: picture == null
                      ? Center(child: Text('Selecione uma imagem'))
                      : Image.file(
                          picture!,
                          height: 100,
                          width: 100,
                          fit: BoxFit.cover,
                        ),
                ),
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: uploadImage,
                child: Container(
                  width: 100,
                  height: 50,
                  color: Colors.blue,
                  alignment: Alignment.center,
                  child: Text(
                    'Enviar',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
