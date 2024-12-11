import 'package:hive/hive.dart';

part 'person_modal.g.dart';

@HiveType(typeId: 0)
class PersonModal {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String age;
  @HiveField(2)
  final String phone;

  PersonModal({required this.name, required this.age, required this.phone});
}
