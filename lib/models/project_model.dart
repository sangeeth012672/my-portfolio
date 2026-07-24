import 'package:flutter/material.dart';

class ProjectModel {
  final String title;
  final String subtitle;
  final String description;
  final List<String> features;
  final List<String> techStack;
  final String category;
  final List<Color> gradient;
  final IconData icon;
  final String githubUrl;
  final String liveUrl;
  final bool featured;

  const ProjectModel({
    required this.title,
    required this.subtitle,
    required this.description,
    required this.features,
    required this.techStack,
    required this.category,
    required this.gradient,
    required this.icon,
    required this.githubUrl,
    required this.liveUrl,
    required this.featured,
  });
}
