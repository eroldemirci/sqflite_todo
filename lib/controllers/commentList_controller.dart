import 'package:flutter_sqflite_todo/db/databaseHelper.dart';
import 'package:flutter_sqflite_todo/model/userComent_model.dart';
import 'package:get/get.dart';

class CommentListController extends GetxController {
  final DatabaseHelper dbHelper = DatabaseHelper.instance;
  RxBool isLoading = true.obs;
  RxList<UserComent?> commentList = [null].obs;

  @override
  void onInit() {
    getComentList();
    super.onInit();
  }

  getComentList() async {
    try {
      isLoading = true.obs;
      var data = await dbHelper.getCommentList();
      commentList = data.obs;
      update();
      isLoading = false.obs;
    } on Exception catch (e) {
      print(e.toString());
    }
  }

  removeSelectedData(int? id) async {
    await dbHelper.remove(id!);
    getComentList();
  }

  addNote(String title, String description) async {
    await dbHelper
        .addComment(UserComent(name: title, description: description));
    getComentList();
  }

  updateNote(UserComent comment) async {
    await dbHelper.update(comment);
    getComentList();
  }
}
