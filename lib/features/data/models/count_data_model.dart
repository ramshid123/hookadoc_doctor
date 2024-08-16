import 'package:hookadoc_server/features/domain/entities/count_data_entity.dart';

class CountDataModel extends CountDataEntity {
  CountDataModel(
      {required super.today,
      required super.pending,
      required super.done,
      required super.missed});
}
