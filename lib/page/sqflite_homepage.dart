import 'package:flutter/material.dart';
import 'package:flutter_sqflite_todo/db/grocery_dbHelper.dart';
import 'package:flutter_sqflite_todo/model/grocery_model.dart';
import 'package:getwidget/getwidget.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController _controller = TextEditingController();

  GroceryDatabaseHelper? dbHelper;
  List<Grocery> groceryList = [];
  bool isloading = true;
  @override
  void initState() {
    super.initState();
    dbHelper = GroceryDatabaseHelper.instance;
    getGrocery();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Form(
          child: TextFormField(
            controller: _controller,
            decoration: InputDecoration(fillColor: Colors.white, filled: true),
          ),
        ),
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              onPrimary: Colors.white,
              primary: _controller.text.isEmpty ? null : Colors.blue,
            ),
            onPressed: () => saveGrocery(),
            child: Text(
              'Save',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: Container(
        alignment: Alignment.topCenter,
        child: groceryList.isEmpty
            ? Center(
                child: Text('Hiç Bilgi Yok'),
              )
            : ListView(
                children: groceryList
                    .map(
                      (grocery) => ListTile(
                        onTap: () {
                          removeSelectedData(grocery.id);
                        },
                        title: Text(
                          grocery.name.toString(),
                        ),
                      ),
                    )
                    .toList(),
              ),
      ),
    );
  }

  saveGrocery() {
    if (_controller.text.length > 0) {
      dbHelper!.add(Grocery(name: _controller.text));
      getGrocery();
      _controller.clear();
    } else {
      print('Boş alanı doldurun');
    }
  }

  getGrocery() async {
    groceryList.clear();
    setState(() {
      isloading = true;
    });

    this.groceryList = await dbHelper!.getGroceries();

    setState(() {
      isloading = false;
    });
  }

  removeSelectedData(int? id) {
    dbHelper!.remove(id!);
    getGrocery();
  }

  showAlertDialog(String? title, int? id) {
    print(title.toString() + 'id :' + id.toString());
    return GFAlert(
      title: title,
      content: 'Silmek İstiyor Musunuz?',
    );
  }
}
