import '../domain/entities/client.dart';
import '../../../../generated_code/swagger.swagger.dart';

extension ClientMapper on Map<String, dynamic> {
  Client toDomain() {
    ClientStatus parsedStatus;
    switch (this['status']) {
      case 'active':
        parsedStatus = ClientStatus.active;
        break;
      case 'inactive':
        parsedStatus = ClientStatus.inactive;
        break;
      case 'prospect':
        parsedStatus = ClientStatus.prospect;
        break;
      default:
        parsedStatus = ClientStatus.prospect;
    }

    return Client(
      id: this['_id'] ?? this['id'] ?? '',
      name: this['name'] ?? '',
      company: this['company'] ?? '',
      email: this['email'] ?? '',
      phone: this['phone'],
      totalProjects: this['totalProjects'] ?? 0,
      status: parsedStatus,
      imageUrl: this['image'], // using image or imageUrl depending on API
      createdAt: this['createdAt'] != null
          ? DateTime.tryParse(this['createdAt'])
          : null,
      updatedAt: this['updatedAt'] != null
          ? DateTime.tryParse(this['updatedAt'])
          : null,
    );
  }
}

extension ClientDomainMapper on Client {
  CreateClientDTO toCreateDto() {
    return CreateClientDTO(
      name: name,
      company: company,
      email: email,
      phone: phone,
      totalProjects: totalProjects.toDouble(),
      status: CreateClientDTOStatus.values.firstWhere(
        (e) => e.value == status.name,
        orElse: () => CreateClientDTOStatus.prospect,
      ),
    );
  }

  UpdateClientDTO toUpdateDto() {
    return UpdateClientDTO(
      name: name,
      company: company,
      email: email,
      phone: phone,
      totalProjects: totalProjects.toDouble(),
      status: UpdateClientDTOStatus.values.firstWhere(
        (e) => e.value == status.name,
        orElse: () => UpdateClientDTOStatus.prospect,
      ),
    );
  }
}
