import 'package:json_annotation/json_annotation.dart';
import 'package:collection/collection.dart';

enum CreateUserDTORole {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('super_admin')
  superAdmin('super_admin'),
  @JsonValue('admin')
  admin('admin'),
  @JsonValue('user')
  user('user');

  final String? value;

  const CreateUserDTORole(this.value);
}

enum UserResponseDTORole {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('super_admin')
  superAdmin('super_admin'),
  @JsonValue('admin')
  admin('admin'),
  @JsonValue('user')
  user('user');

  final String? value;

  const UserResponseDTORole(this.value);
}

enum UpdateFeedbackStatusDTOStatus {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('pending')
  pending('pending'),
  @JsonValue('reviewed')
  reviewed('reviewed'),
  @JsonValue('resolved')
  resolved('resolved');

  final String? value;

  const UpdateFeedbackStatusDTOStatus(this.value);
}

enum CustomerFeedbackByStatusGetStatus {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('pending')
  pending('pending'),
  @JsonValue('reviewed')
  reviewed('reviewed'),
  @JsonValue('resolved')
  resolved('resolved');

  final String? value;

  const CustomerFeedbackByStatusGetStatus(this.value);
}
