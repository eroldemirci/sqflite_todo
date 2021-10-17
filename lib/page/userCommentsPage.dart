import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sqflite_todo/controllers/commentList_controller.dart';
import 'package:flutter_sqflite_todo/db/databaseHelper.dart';
import 'package:flutter_sqflite_todo/model/userComent_model.dart';
import 'package:flutter_sqflite_todo/page/add_note_page.dart';
import 'package:get/get.dart';

class UserCommentsPage extends StatefulWidget {
  const UserCommentsPage({Key? key}) : super(key: key);

  @override
  _UserCommentsPageState createState() => _UserCommentsPageState();
}

class _UserCommentsPageState extends State<UserCommentsPage> {
  DatabaseHelper? dbHelper;
  bool isloading = true;
  List<UserComent> dataList = [];
  CommentListController _controller = Get.put(CommentListController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text(
          'Notlarım',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        toolbarHeight: size.height * 0.075,
      ),
      body: GetBuilder<CommentListController>(
        builder: (_controller) => _controller.isLoading.value
            ? Center(
                child: CircularProgressIndicator(),
              )
            : _controller.commentList.value.length == 0
                ? Center(
                    child: Text('Hiç Not bulunamadı'),
                  )
                : ListView.builder(
                    itemCount: _controller.commentList.length,
                    itemBuilder: (context, index) {
                      UserComent? comment = _controller.commentList[index]!;
                      return Card(
                        child: ListTile(
                          onTap: () => Get.to(AddNotePage(
                            userComent: comment,
                          )),
                          trailing: IconButton(
                            onPressed: () =>
                                _controller.removeSelectedData(comment.id),
                            icon: Icon(
                              CupertinoIcons.delete,
                              color: Colors.red,
                            ),
                          ),
                          title: Text(comment.name!.toString()),
                        ),
                      );
                    },
                  ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(AddNotePage()),
        child: Icon(Icons.add),
      ),
    );
  }
}
