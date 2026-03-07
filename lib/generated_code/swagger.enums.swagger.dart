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

enum CreateClientDTOStatus {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('active')
  active('active'),
  @JsonValue('inactive')
  inactive('inactive'),
  @JsonValue('prospect')
  prospect('prospect');

  final String? value;

  const CreateClientDTOStatus(this.value);
}

enum UpdateClientDTOStatus {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('active')
  active('active'),
  @JsonValue('inactive')
  inactive('inactive'),
  @JsonValue('prospect')
  prospect('prospect');

  final String? value;

  const UpdateClientDTOStatus(this.value);
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

enum ApiClientsGetStatus {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('active')
  active('active'),
  @JsonValue('inactive')
  inactive('inactive'),
  @JsonValue('prospect')
  prospect('prospect');

  final String? value;

  const ApiClientsGetStatus(this.value);
}

enum ApiClientsGetSortOrder {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('asc')
  asc('asc'),
  @JsonValue('desc')
  desc('desc');

  final String? value;

  const ApiClientsGetSortOrder(this.value);
}

enum ApiClientsSearchGetStatus {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('active')
  active('active'),
  @JsonValue('inactive')
  inactive('inactive'),
  @JsonValue('prospect')
  prospect('prospect');

  final String? value;

  const ApiClientsSearchGetStatus(this.value);
}

enum ApiClientsSearchGetSortOrder {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('asc')
  asc('asc'),
  @JsonValue('desc')
  desc('desc');

  final String? value;

  const ApiClientsSearchGetSortOrder(this.value);
}
