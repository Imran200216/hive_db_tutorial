import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive_db_tutorial/features/edit_notes/presentation/edit_notes_screen.dart';
import 'package:hive_db_tutorial/modals/person_modal.dart';
import 'package:hive_flutter/hive_flutter.dart';

class DisplayNotesScreen extends StatelessWidget {
  const DisplayNotesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_outlined,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.black,
        title: const Text("Details screen"),
        titleTextStyle: const TextStyle(
          color: Colors.white,
        ),
      ),
      body: FutureBuilder(
        future: Hive.openBox("PersonBox"),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            final hiveBox = Hive.box("PersonBox");

            return ValueListenableBuilder(
              valueListenable: hiveBox.listenable(),
              builder: (context, value, child) {
                return ListView.builder(
                  itemCount: hiveBox.length, // Specify the item count
                  itemBuilder: (context, index) {
                    /// Getting data
                    final helper = hiveBox.getAt(index) as PersonModal;

                    return ListTile(
                      leading: IconButton(
                        onPressed: () async {
                          // Handle deletion logic here
                          await Hive.box("PersonBox").deleteAt(index).then(
                            (value) {
                              Fluttertoast.showToast(
                                msg: "Delete to Hive",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0,
                              );
                            },
                          );
                        },
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                      ),
                      trailing: IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return EditNotesScreen(index: index);
                              },
                            ),
                          );
                        },
                        icon: const Icon(
                          Icons.edit,
                          color: Colors.green,
                        ),
                      ),
                      title: Text(helper.name),
                      subtitle: Text(helper.phone),
                    );
                  },
                );
              },
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return const Center(
                child: Text('Error loading data')); // Handle error cases
          }
        },
      ),
    );
  }
}
