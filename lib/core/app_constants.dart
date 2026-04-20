import 'package:flutter/material.dart';
import 'package:flutter_app/models/experience_model.dart';
import 'package:flutter_app/models/project_model.dart';
import 'package:flutter_app/models/skill_model.dart';

class AppConstants {
  AppConstants._();

  // === Personal Info ===
  static const String name = 'Alex Carter';
  static const String role = 'Flutter Developer';
  static const String tagline =
      'Crafting beautiful, performant mobile experiences\nthat users love to interact with.';
  static const String bio =
      'I\'m a passionate Flutter Developer with 4+ years of experience building '
      'cross-platform mobile applications that deliver exceptional user experiences. '
      'I specialize in creating pixel-perfect UIs, integrating complex animations, '
      'and architecting scalable apps using modern patterns like BLoC, Riverpod, and Clean Architecture. '
      'Every line of code I write is for performance, maintainability, and user delight.';

  static const String email = 'alex.carter@flutter.dev';
  static const String phone = '+1 (555) 234-5678';
  static const String location = 'San Francisco, CA';
  static const String githubUrl = 'https://github.com/';
  static const String linkedinUrl = 'https://linkedin.com/';
  static const String twitterUrl = 'https://twitter.com/';
  static const String resumeUrl = 'https://drive.google.com/';

  // === Stats ===
  static const int yearsExperience = 4;
  static const int projectsCompleted = 35;
  static const int happyClients = 28;
  static const int githubStars = 500;

  // === Typing Roles ===
  static const List<String> typingRoles = [
    'Flutter Developer',
    'Mobile Architect',
    'UI / UX Enthusiast',
    'Open Source Contributor',
    'Dart Craftsman',
  ];

  // === Skills ===
  static final List<SkillModel> skills = [
    SkillModel(name: 'Flutter', level: 0.95, category: 'Mobile'),
    SkillModel(name: 'Dart', level: 0.93, category: 'Language'),
    SkillModel(name: 'Firebase', level: 0.88, category: 'Backend'),
    SkillModel(name: 'BLoC / Cubit', level: 0.90, category: 'State Mgmt'),
    SkillModel(name: 'Riverpod', level: 0.85, category: 'State Mgmt'),
    SkillModel(name: 'REST APIs', level: 0.92, category: 'Integration'),
    SkillModel(name: 'GetX', level: 0.87, category: 'State Mgmt'),
    SkillModel(name: 'Git & CI/CD', level: 0.84, category: 'DevOps'),
    SkillModel(name: 'UI Animation', level: 0.91, category: 'Design'),
    SkillModel(name: 'SQLite', level: 0.80, category: 'Database'),
    SkillModel(name: 'Figma', level: 0.78, category: 'Design'),
    SkillModel(name: 'GraphQL', level: 0.75, category: 'Integration'),
  ];

  // === Projects ===
  static final List<ProjectModel> projects = [
    ProjectModel(
      title: 'FinFlow — Banking App',
      description:
          'A modern banking app with real-time transaction tracking, biometric auth, '
          'expense analytics with custom charts, and seamless card management.',
      techStack: ['Flutter', 'Firebase', 'BLoC', 'Plaid API', 'Hive'],
      gradient: const [Color(0xFF00E5FF), Color(0xFF0072FF)],
      githubUrl: 'https://github.com/',
      liveUrl: '',
      featured: true,
    ),
    ProjectModel(
      title: 'MediCare — Health Tracker',
      description:
          'Health monitoring app with AI-powered symptom checker, appointment booking, '
          'prescription reminders, and wearable device integration via Bluetooth.',
      techStack: ['Flutter', 'Riverpod', 'Node.js', 'MongoDB', 'BLE'],
      gradient: const [Color(0xFF00FF88), Color(0xFF00C4FF)],
      githubUrl: 'https://github.com/',
      liveUrl: '',
      featured: true,
    ),
    ProjectModel(
      title: 'EduMind — E-Learning',
      description:
          'Feature-rich e-learning platform with video streaming, offline downloads, '
          'interactive quizzes, progress tracking, and live class sessions.',
      techStack: ['Flutter', 'GetX', 'Django', 'PostgreSQL', 'WebRTC'],
      gradient: const [Color(0xFFBB86FC), Color(0xFFFF4081)],
      githubUrl: 'https://github.com/',
      liveUrl: '',
      featured: true,
    ),
    ProjectModel(
      title: 'ShopNest — E-Commerce',
      description:
          'Full-featured e-commerce app with AR try-on, Stripe payments, '
          'real-time inventory, push notifications, and advanced product filtering.',
      techStack: ['Flutter', 'Firebase', 'Stripe', 'AR Core', 'BLoC'],
      gradient: const [Color(0xFFFFB300), Color(0xFFFF4081)],
      githubUrl: 'https://github.com/',
      liveUrl: '',
      featured: false,
    ),
    ProjectModel(
      title: 'TravelGo — Trip Planner',
      description:
          'Smart travel planner with AI itinerary generation, offline maps, '
          'currency converter, hotel & flight booking, and social sharing.',
      techStack: ['Flutter', 'Riverpod', 'Google Maps', 'OpenAI', 'Supabase'],
      gradient: const [Color(0xFF29B6F6), Color(0xFF66BB6A)],
      githubUrl: 'https://github.com/',
      liveUrl: '',
      featured: false,
    ),
    ProjectModel(
      title: 'ChatSphere — Messaging',
      description:
          'End-to-end encrypted messaging app with voice/video calls, '
          'story features, animated stickers, and multi-device sync.',
      techStack: ['Flutter', 'Firebase', 'WebRTC', 'AES Encryption', 'GetX'],
      gradient: const [Color(0xFFFF7043), Color(0xFFBB86FC)],
      githubUrl: 'https://github.com/',
      liveUrl: '',
      featured: false,
    ),
  ];

  // === Experience ===
  static final List<ExperienceModel> experiences = [
    ExperienceModel(
      role: 'Senior Flutter Developer',
      company: 'TechNova Inc.',
      period: 'Jan 2023 – Present',
      description:
          'Led a team of 5 developers building a cross-platform fintech app serving 200K+ users. '
          'Designed micro-frontend architecture, reduced app startup time by 40%, '
          'and integrated real-time analytics dashboards with custom chart animations.',
      technologies: ['Flutter', 'BLoC', 'Firebase', 'Fastlane', 'GraphQL'],
      isPresent: true,
    ),
    ExperienceModel(
      role: 'Flutter Developer',
      company: 'PixelForge Studio',
      period: 'Mar 2021 – Dec 2022',
      description:
          'Built 8 client apps for healthcare, e-learning, and retail verticals. '
          'Pioneered animation-first development workflow, achieving 60fps smooth UIs across devices. '
          'Mentored 3 junior developers and established code review culture.',
      technologies: ['Flutter', 'Riverpod', 'REST APIs', 'Hive', 'Dio'],
      isPresent: false,
    ),
    ExperienceModel(
      role: 'Mobile Developer (Intern → Full-time)',
      company: 'AppCraft Labs',
      period: 'Jun 2020 – Feb 2021',
      description:
          'Started as intern, converted to full-time after shipping a fitness tracking app '
          'that reached 50K downloads in 3 months. Gained deep expertise in Flutter animations '
          'and platform channel integrations.',
      technologies: ['Flutter', 'GetX', 'SQLite', 'ARCore', 'Notifications'],
      isPresent: false,
    ),
  ];
}
