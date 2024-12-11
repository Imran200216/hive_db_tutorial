import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive_db_tutorial/commons/widgets/custom_btn.dart';
import 'package:hive_db_tutorial/features/add_notes/presentation/widgets/custom_text_field.dart';
import 'package:hive_db_tutorial/features/display_notes/presentation/pages/display_notes_screen.dart';
import 'package:hive_db_tutorial/modals/person_modal.dart';
import 'package:hive_flutter/hive_flutter.dart';

class EditNotesScreen extends StatelessWidget {
  final int index;

  const EditNotesScreen({
    super.key,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    /// Text Editing controllers
    final TextEditingController nameController = TextEditingController();
    final TextEditingController ageController = TextEditingController();
    final TextEditingController phoneController = TextEditingController();

    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(
          left: 20,
          right: 20,
          bottom: 30,
          top: 30,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Add notes",
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: Colors.black,
                fontSize: 30,
              ),
            ),

            const SizedBox(
              height: 30,
            ),

            /// name text field
            CustomTextField(
              textEditingController: nameController,
              labelText: "Name",
              keyboardType: TextInputType.name,
            ),
            const SizedBox(
              height: 30,
            ),

            /// age text field
            CustomTextField(
              textEditingController: ageController,
              labelText: "Age",
              keyboardType: TextInputType.number,
            ),

            const SizedBox(
              height: 30,
            ),

            /// phone text field
            CustomTextField(
              textEditingController: phoneController,
              labelText: "Phone Number",
              keyboardType: TextInputType.phone,
            ),

            const SizedBox(
              height: 40,
            ),

            /// add to db btn
            CustomBtn(
              onTap: () async {
                final value = PersonModal(
                  name: nameController.text.trim(),
                  age: ageController.text.trim(),
                  phone: phoneController.text.trim(),
                );

                (nameController.text.isEmpty &&
                        ageController.text.isEmpty &&
                        phoneController.text.isEmpty)
                    ? Fluttertoast.showToast(
                        msg: "Fill all details",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.black,
                        textColor: Colors.white,
                        fontSize: 16.0,
                      )
                    :

                    /// hive storage name
                    await Hive.box("PersonBox").putAt(index, value).then(
                        (value) {
                          Fluttertoast.showToast(
                            msg: "Delete in Hive",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.black,
                            textColor: Colors.white,
                            fontSize: 16.0,
                          );
                        },
                      );

                Navigator.pushReplacement(context, MaterialPageRoute(
                  builder: (context) {
                    return const DisplayNotesScreen();
                  },
                ));
              },
              btnText: "Update Notes",
            ),

            const SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}
