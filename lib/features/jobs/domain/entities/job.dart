import '../../../../generated_code/swagger.swagger.dart';

/// Job type enum
enum JobType {
  fullTime,
  partTime,
  contract,
  freelance,
  internship;

  String get label {
    switch (this) {
      case JobType.fullTime:
        return 'Full Time';
      case JobType.partTime:
        return 'Part Time';
      case JobType.contract:
        return 'Contract';
      case JobType.freelance:
        return 'Freelance';
      case JobType.internship:
        return 'Internship';
    }
  }

  String get apiValue {
    switch (this) {
      case JobType.fullTime:
        return 'full-time';
      case JobType.partTime:
        return 'part-time';
      case JobType.contract:
        return 'contract';
      case JobType.freelance:
        return 'freelance';
      case JobType.internship:
        return 'internship';
    }
  }

  static JobType fromString(String? value) {
    switch (value?.toLowerCase()) {
      case 'full-time':
      case 'fulltime':
      case 'full_time':
        return JobType.fullTime;
      case 'part-time':
      case 'parttime':
      case 'part_time':
        return JobType.partTime;
      case 'contract':
        return JobType.contract;
      case 'freelance':
        return JobType.freelance;
      case 'internship':
        return JobType.internship;
      default:
        return JobType.fullTime;
    }
  }
}

/// Job entity mapped from CreateCareerDTO
class Job {
  final String? id;
  final String title;
  final String description;
  final String? location;
  final JobType type;
  final String? salary;
  final bool isActive;

  const Job({
    this.id,
    this.title = '',
    this.description = '',
    this.location,
    this.type = JobType.fullTime,
    this.salary,
    this.isActive = true,
  });

  /// Create Job from Swagger-generated CreateCareerDTO
  factory Job.fromDto(CreateCareerDTO dto) {
    return Job(
      title: dto.title ?? '',
      description: dto.description ?? '',
      location: dto.location,
      type: JobType.fromString(dto.type),
      salary: dto.salary,
      isActive: dto.isActive ?? true,
    );
  }

  /// Create Job from raw JSON map (null-safe)
  factory Job.fromJson(Map<String, dynamic> json) {
    return Job(
      id: json['_id']?.toString() ?? json['id']?.toString() ?? '',
      title: json['title']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      location: json['location']?.toString(),
      type: JobType.fromString(json['type']?.toString() ?? ''),
      salary: json['salary']?.toString() ?? '',
      isActive: json['isActive'] as bool? ?? true,
    );
  }

  /// Convert Job to CreateCareerDTO for API calls
  CreateCareerDTO toDto() {
    return CreateCareerDTO(
      title: title,
      description: description,
      location: location,
      type: type.apiValue,
      salary: salary,
      isActive: isActive,
    );
  }

  Job copyWith({
    String? id,
    String? title,
    String? description,
    String? location,
    JobType? type,
    String? salary,
    bool? isActive,
  }) {
    return Job(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      location: location ?? this.location,
      type: type ?? this.type,
      salary: salary ?? this.salary,
      isActive: isActive ?? this.isActive,
    );
  }

  String get typeLabel => type.label;

  String get statusLabel => isActive ? 'Active' : 'Inactive';
}
