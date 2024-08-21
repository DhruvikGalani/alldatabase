import 'package:hive_flutter/adapters.dart';
part 'hiveclass.g.dart';

@HiveType(typeId: 1)
class hiveclass extends HiveObject {
  @HiveField(0)
  String? title;
  @HiveField(1)
  String? discription;
  hiveclass(this.title, this.discription) {
    this.title = title;
    this.discription = discription;
  }
}
