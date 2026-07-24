class ExperienceModel {
  final String role;
  final String company;
  final String location;
  final String period;
  final String type;
  final String description;
  final List<String> bulletPoints;
  final List<String> technologies;
  final bool isPresent;

  const ExperienceModel({
    required this.role,
    required this.company,
    required this.location,
    required this.period,
    required this.type,
    required this.description,
    required this.bulletPoints,
    required this.technologies,
    required this.isPresent,
  });
}
