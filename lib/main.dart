import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_db_tutorial/features/add_notes/presentation/pages/add_notes_screen.dart';
import 'package:hive_db_tutorial/modals/person_modal.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// local directory
  final directory = await getApplicationDocumentsDirectory();

  /// init hive
  Hive.init(directory.path);

  /// open hive db box
  Hive.openBox("PersonBox");

  /// register the adaptor in hive
  Hive.registerAdapter(PersonModalAdapter());

  runApp(
  const
  MyApp
  (
  )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      home: AddNotesScreen(),
    );
  }
}
