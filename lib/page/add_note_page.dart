import 'package:flutter/material.dart';
import 'package:flutter_sqflite_todo/controllers/commentList_controller.dart';
import 'package:flutter_sqflite_todo/db/databaseHelper.dart';
import 'package:flutter_sqflite_todo/model/userComent_model.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/button/gf_button.dart';

class AddNotePage extends StatefulWidget {
  AddNotePage({Key? key, this.id, this.userComent}) : super(key: key);

  int? id;
  UserComent? userComent;
  @override
  _AddNotePageState createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {
  TextEditingController? _name;
  TextEditingController? _description;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  DatabaseHelper dbHelper = DatabaseHelper.instance;

  CommentListController _controller = Get.find();

  @override
  void initState() {
    super.initState();
    // _name = TextEditingController(text: usercoment!.name.toString());
    // _description =
    //     TextEditingController(text: usercoment!.description.toString());
    print(''.toString() + widget.userComent!.name.toString());
    print(widget.userComent!.description);
    _name = TextEditingController(text: widget.userComent!.name.toString());
    _description =
        TextEditingController(text: widget.userComent!.description.toString());
  }

  addNote() {
    if (_formKey.currentState!.validate()) {
      _controller.addNote(_name!.text, _description!.text);

      _name!.clear();
      _description!.clear();
      Get.back();
      print('başarıyla eklendi');
    } else {
      print('eklenemedi');
    }
  }

  updateNote(UserComent comment) {
    if (_formKey.currentState!.validate()) {
      _controller.updateNote(comment);
    }
  }

  String? validate(String text) {
    if (text.isEmpty) {
      return 'Lütfen Boş bırakmayın';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(28.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    validator: (value) => validate(value!),
                    controller: _name,
                    decoration: InputDecoration(
                        hintText: 'Başlık',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue),
                        )),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    validator: (value) => validate(value!),
                    controller: _description,
                    maxLines: 8,
                    decoration: InputDecoration(
                        hintText: 'Not açıklaması',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue),
                        )),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  GFButton(
                    onPressed: widget.userComent == null
                        ? addNote
                        : updateNote(
                            UserComent(
                                name: _name!.text,
                                description: _description!.text),
                          ),
                    fullWidthButton: true,
                    text: 'Kaydet',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
