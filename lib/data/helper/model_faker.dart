import 'package:faker/faker.dart';
import 'package:uuid/uuid.dart';

abstract class ModelFaker<T> {
  Faker get faker => Faker();

  /// Generate a single fake model.
  T generateFake();

  /// Generate fake list based on provided length.
  List<T> generateFakeList({required int length});
}
