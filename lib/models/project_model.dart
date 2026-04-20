import 'dart:ui' show Color;

class ProjectModel {
  final String title;
  final String description;
  final List<String> techStack;
  final List<Color> gradient;
  final String githubUrl;
  final String liveUrl;
  final bool featured;

  const ProjectModel({
    required this.title,
    required this.description,
    required this.techStack,
    required this.gradient,
    required this.githubUrl,
    required this.liveUrl,
    required this.featured,
  });
}
