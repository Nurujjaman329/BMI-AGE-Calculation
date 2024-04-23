import 'package:flutter/material.dart';
import 'package:google_map_practise/sqflite_try/db_handler.dart';
import 'package:google_map_practise/sqflite_try/notes.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void _showBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 600,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: titleController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hintText: 'Enter title',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please fill the field';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    // Handle button press here
                    // For example, you can add data to the database
                    // and close the bottom sheet
                    _dbHelper!
                        .insert(
                      NotesModel(
                        title: titleController.text,
                        age: 24,
                        description: titleController.text,
                        email: 'test@gmail.com',
                      ),
                    )
                        .then((value) {
                      print('Data Added');
                      setState(() {
                        notesList = _dbHelper!.getNotesList();
                      });
                      Navigator.pop(context); // Close the bottom sheet
                    }).onError((error, stackTrace) {
                      print(error.toString());
                    });
                  },
                  child: Text('Add'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  final titleController = TextEditingController();
  final ageController = TextEditingController();
  final descriptionController = TextEditingController();
  final emailController = TextEditingController();
  DBHelper? _dbHelper;
  late Future<List<NotesModel>> notesList;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _dbHelper = DBHelper();
    loadData();
  }

  loadData() async {
    notesList = _dbHelper!.getNotesList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Notes SQL',
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
                future: notesList,
                builder: (context, AsyncSnapshot<List<NotesModel>> snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            _dbHelper!.upDate(
                              NotesModel(
                                id: snapshot.data![index].id!,
                                title: 'Updated Note',
                                age: 25,
                                description: "Test purpose",
                                email: 'test_note@gmail.com',
                              ),
                            );
                            setState(() {
                              notesList = _dbHelper!.getNotesList();
                            });
                          },
                          child: Dismissible(
                            direction: DismissDirection.endToStart,
                            key: ValueKey<int>(snapshot.data![index].id!),
                            onDismissed: (DismissDirection direction) {
                              setState(() {
                                _dbHelper!.delete(snapshot.data![index].id!);
                                notesList = _dbHelper!.getNotesList();
                                snapshot.data!.remove(snapshot.data![index]);
                              });
                            },
                            background: Container(
                              color: Colors.red,
                              child: Icon(
                                Icons.delete_forever,
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(
                                left: 5.0,
                                right: 5.0,
                              ),
                              child: Card(
                                child: ListTile(
                                  contentPadding: EdgeInsets.all(0.0),
                                  title: Text(snapshot.data![index].title),
                                  subtitle:
                                      Text(snapshot.data![index].description),
                                  trailing: Text(
                                      snapshot.data![index].age.toString()),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  } else {
                    return CircularProgressIndicator();
                  }
                }),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showBottomSheet,
        child: Icon(Icons.add),
      ),
    );
  }
}
