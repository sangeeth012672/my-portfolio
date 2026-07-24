import 'package:flutter/material.dart';
import '../models/education_model.dart';
import '../models/experience_model.dart';
import '../models/project_model.dart';
import '../models/skill_model.dart';

class AppConstants {
  AppConstants._();

  // === Personal Info ===
  static const String name = 'Sangeeth K Sambasivan';
  static const String role = 'Flutter Developer';
  static const String tagline =
      'Crafting high-performance cross-platform mobile apps with Flutter, Dart & Django Backends.';
  static const String bio =
      'I am a dedicated Flutter Developer based in Thrissur, Kerala, with extensive experience '
      'designing and building cross-platform mobile applications using Flutter and Dart. '
      'My technical expertise encompasses REST API integration with Python Django backends, Firebase services, '
      'and Provider & BLoC state management architectures. I thrive in creating responsive mobile interfaces, '
      'optimizing app performance, and delivering clean, maintainable code within agile development workflows.';

  static const String email = 'sangeethks742@gmail.com';
  static const String phone1 = '+91 95672 59782';
  static const String phone2 = '+91 97780 04059';
  static const String whatsappUrl = 'https://wa.me/919567259782';
  static const String location = 'Thrissur, Kerala, India';
  static const String githubUrl = 'https://github.com/';
  static const String linkedinUrl = 'https://linkedin.com/';
  static const String resumeUrl = '#'; // Download trigger

  // === Stats ===
  static const int yearsExperience = 2;
  static const int projectsCompleted = 10;
  static const int mobileAppsBuilt = 8;
  static const int webProjectsBuilt = 2;

  // === Typing Roles ===
  static const List<String> typingRoles = [
    'Flutter Developer',
    'Mobile Application Engineer',
    'Provider & BLoC Architect',
    'Django REST API Integrator',
    'Cross-Platform Craftsman',
  ];

  // === Skill Categories ===
  static const List<String> skillCategories = [
    'All',
    'Frameworks',
    'State Mgmt',
    'APIs & Cloud',
    'Databases',
    'Tools & Languages',
  ];

  // === Skills ===
  static final List<SkillModel> skills = [
    const SkillModel(name: 'Flutter', level: 0.95, category: 'Frameworks'),
    const SkillModel(name: 'Dart', level: 0.92, category: 'Tools & Languages'),
    const SkillModel(name: 'Provider', level: 0.90, category: 'State Mgmt'),
    const SkillModel(name: 'BLoC', level: 0.88, category: 'State Mgmt'),
    const SkillModel(name: 'REST APIs', level: 0.92, category: 'APIs & Cloud'),
    const SkillModel(name: 'Python Django API', level: 0.85, category: 'APIs & Cloud'),
    const SkillModel(name: 'Firebase', level: 0.88, category: 'APIs & Cloud'),
    const SkillModel(name: 'Dio & HTTP', level: 0.90, category: 'APIs & Cloud'),
    const SkillModel(name: 'SQLite', level: 0.86, category: 'Databases'),
    const SkillModel(name: 'Hive', level: 0.84, category: 'Databases'),
    const SkillModel(name: 'Java / Android', level: 0.80, category: 'Frameworks'),
    const SkillModel(name: 'MySQL', level: 0.78, category: 'Databases'),
    const SkillModel(name: 'SQL Server', level: 0.75, category: 'Databases'),
    const SkillModel(name: 'Git & GitHub', level: 0.90, category: 'Tools & Languages'),
    const SkillModel(name: 'Android Studio', level: 0.92, category: 'Tools & Languages'),
    const SkillModel(name: 'VS Code', level: 0.94, category: 'Tools & Languages'),
  ];

  // === Project Categories ===
  static const List<String> projectCategories = [
    'All',
    'Featured',
    'Mobile Apps',
    'Healthcare',
    'Web & Security',
    'AI & Utilities',
  ];

  // === Projects (10 Real CV Projects) ===
  static final List<ProjectModel> projects = [
    const ProjectModel(
      title: 'Expense Manager App',
      subtitle: 'Offline-First Financial Tracking & Budget Sync',
      description:
          'An offline-first expense management mobile app engineered with BLoC pattern for predictable state flow and SQLite for local data persistence, featuring budget analytics and optional REST API cloud sync.',
      features: [
        'Offline-first architecture powered by SQLite local database',
        'BLoC state management pattern for reactive UI updates',
        'Interactive spending analytics & category breakdown charts',
        'Optional REST API sync for cloud backup',
        'Custom budget goals and alert notifications',
      ],
      techStack: ['Flutter', 'BLoC', 'SQLite', 'REST API', 'Dart'],
      category: 'Mobile Apps',
      gradient: [Color(0xFF00E5FF), Color(0xFF0072FF)],
      icon: Icons.account_balance_wallet_rounded,
      githubUrl: 'https://github.com/',
      liveUrl: '',
      featured: true,
    ),
    const ProjectModel(
      title: 'Learning Management System (LMS)',
      subtitle: 'Course Management & E-Learning Portal',
      description:
          'A feature-rich learning management mobile app built with Flutter and REST API integration to Django backends, offering interactive course modules, lesson progress tracking, and student assessments.',
      features: [
        'Course catalog with video streaming integration',
        'REST API integration with Python Django backend',
        'Real-time student progress tracking & module completion',
        'Interactive quizzes with instant score evaluation',
        'Offline material download and bookmarking',
      ],
      techStack: ['Flutter', 'Provider', 'REST API', 'Django', 'Dio'],
      category: 'Mobile Apps',
      gradient: [Color(0xFFBB86FC), Color(0xFFFF4081)],
      icon: Icons.school_rounded,
      githubUrl: 'https://github.com/',
      liveUrl: '',
      featured: true,
    ),
    const ProjectModel(
      title: 'MyCISO Platform',
      subtitle: 'Cybersecurity Governance & Compliance Management',
      description:
          'Contributed to the web application development for cybersecurity governance, risk management, and compliance auditing, helping companies maintain regulatory security frameworks.',
      features: [
        'Cybersecurity risk assessment dashboard',
        'Compliance framework matrix visualizer',
        'Audit report generation and security scoring',
        'Responsive layout for security officers & executives',
        'Role-based access management UI',
      ],
      techStack: ['Flutter Web', 'REST API', 'Provider', 'Cybersecurity'],
      category: 'Web & Security',
      gradient: [Color(0xFF00FF88), Color(0xFF00E5FF)],
      icon: Icons.shield_rounded,
      githubUrl: 'https://github.com/',
      liveUrl: '',
      featured: true,
    ),
    const ProjectModel(
      title: 'Highland Website',
      subtitle: 'Responsive Cross-Device Web Portal',
      description:
          'Designed and developed pixel-perfect responsive user interfaces for desktop monitors, tablets, and mobile smartphones with high performance and smooth scroll aesthetics.',
      features: [
        'Multi-device responsive layout architecture',
        'Custom animation transitions and typography scaling',
        'Cross-browser rendering optimization',
        'Fast asset loading & image compression',
      ],
      techStack: ['Flutter Web', 'Responsive Layouts', 'Dart', 'CSS FX'],
      category: 'Web & Security',
      gradient: [Color(0xFFFFB300), Color(0xFFFF4081)],
      icon: Icons.web_rounded,
      githubUrl: 'https://github.com/',
      liveUrl: '',
      featured: false,
    ),
    const ProjectModel(
      title: 'Patient Mobile Application',
      subtitle: 'Healthcare Patient Medical Data Management',
      description:
          'Healthcare mobile app empowering patients to manage personal medical records, track health histories, book doctor appointments, and receive prescription reminders.',
      features: [
        'Secure patient profile & medical history log',
        'Doctor appointment scheduling & reminder alerts',
        'Real-time health record sync via REST APIs',
        'Encrypted storage of sensitive health documents',
      ],
      techStack: ['Flutter', 'Provider', 'Firebase', 'REST API'],
      category: 'Healthcare',
      gradient: [Color(0xFF29B6F6), Color(0xFF00E5FF)],
      icon: Icons.personal_injury_rounded,
      githubUrl: 'https://github.com/',
      liveUrl: '',
      featured: true,
    ),
    const ProjectModel(
      title: 'Doctor Mobile Application',
      subtitle: 'Clinical Consultations & Digital Prescriptions',
      description:
          'A specialized mobile application for healthcare practitioners to manage patient consultations, issue digital prescriptions, and record clinical notes efficiently.',
      features: [
        'Daily consultation schedule overview',
        'Digital prescription builder with PDF export',
        'Clinical progress notes logging system',
        'Django REST backend integration',
      ],
      techStack: ['Flutter', 'REST API', 'Django', 'Provider'],
      category: 'Healthcare',
      gradient: [Color(0xFFFF7043), Color(0xFFBB86FC)],
      icon: Icons.medical_services_rounded,
      githubUrl: 'https://github.com/',
      liveUrl: '',
      featured: false,
    ),
    const ProjectModel(
      title: 'Legal Advice Chatbot',
      subtitle: 'Conversational Legal Guidance Assistant',
      description:
          'Implemented an AI-assisted conversational mobile app providing automated legal guidance, topic consultation, and legal document template suggestions.',
      features: [
        'Conversational chat UI with instant smart suggestions',
        'Legal query categorizer and reference library',
        'Save & export consultation transcripts',
        'Smooth stateful chat history stream',
      ],
      techStack: ['Flutter', 'REST API', 'Chat UI', 'BLoC'],
      category: 'AI & Utilities',
      gradient: [Color(0xFFBB86FC), Color(0xFF00E5FF)],
      icon: Icons.gavel_rounded,
      githubUrl: 'https://github.com/',
      liveUrl: '',
      featured: false,
    ),
    const ProjectModel(
      title: 'Medicine Reminder App',
      subtitle: 'Medication Tracking with Local Notifications',
      description:
          'A daily health utility application for medication tracking with custom reminder alarms, dosage logs, and refill notifications for patients and caregivers.',
      features: [
        'Customizable pill schedules (daily, weekly, custom cycles)',
        'Local background notification triggers',
        'Dosage history logging & adherence stats',
        'Offline SQLite database storage',
      ],
      techStack: ['Flutter', 'Local Notifications', 'SQLite', 'Hive'],
      category: 'Healthcare',
      gradient: [Color(0xFF00FF88), Color(0xFF29B6F6)],
      icon: Icons.alarm_rounded,
      githubUrl: 'https://github.com/',
      liveUrl: '',
      featured: false,
    ),
    const ProjectModel(
      title: 'Veterinary Management App',
      subtitle: 'Clinic Records & Pet Appointment Scheduler',
      description:
          'Comprehensive veterinary clinic system managing pet medical histories, vaccination schedules, and owner appointment bookings.',
      features: [
        'Pet health profiles & vaccination tracking',
        'Clinic appointment booking & calendar sync',
        'Owner management & service billing summary',
      ],
      techStack: ['Flutter', 'Provider', 'Firebase', 'REST API'],
      category: 'AI & Utilities',
      gradient: [Color(0xFFFFB300), Color(0xFF66BB6A)],
      icon: Icons.pets_rounded,
      githubUrl: 'https://github.com/',
      liveUrl: '',
      featured: false,
    ),
    const ProjectModel(
      title: 'Expiry Management App',
      subtitle: 'Product Expiration Tracker & Alert System',
      description:
          'Inventory utility application that prevents stock waste by tracking product expiration dates and dispatching timely notification alerts.',
      features: [
        'Product barcode scanning & quick manual entry',
        'Expiration countdown visualizer',
        'Custom notification thresholds (e.g. 7 days prior)',
        'Categorized product organization',
      ],
      techStack: ['Flutter', 'Barcode Scanner', 'SQLite', 'Notifications'],
      category: 'AI & Utilities',
      gradient: [Color(0xFFFF4081), Color(0xFFFF7043)],
      icon: Icons.hourglass_bottom_rounded,
      githubUrl: 'https://github.com/',
      liveUrl: '',
      featured: false,
    ),
  ];

  // === Experiences (from CV) ===
  static final List<ExperienceModel> experiences = [
    const ExperienceModel(
      role: 'Flutter Developer',
      company: 'Avanzo Cyber Security Solutions Pvt. Ltd.',
      location: 'Thrissur, Kerala',
      period: 'Nov 2024 – Present',
      type: 'Full-time',
      description:
          'Developing high-performance cross-platform mobile applications, designing modular Flutter UI widgets, and connecting mobile clients with Django REST backends and Firebase services.',
      bulletPoints: [
        'Developing cross-platform mobile applications using Flutter and Dart.',
        'Designing responsive user interfaces and reusable Flutter widgets for multiple screen sizes.',
        'Integrating REST APIs built with Python Django and Firebase backend services.',
        'Managing application state using Provider to improve performance and maintainability.',
        'Collaborating with backend developers and managing source code using Git in an agile development environment.',
      ],
      technologies: ['Flutter', 'Dart', 'Provider', 'Django REST', 'Firebase', 'Git'],
      isPresent: true,
    ),
    const ExperienceModel(
      role: 'Flutter Developer',
      company: 'Grapesgenix Technical Solutions Pvt. Ltd.',
      location: 'Thrissur, Kerala',
      period: 'Apr 2023 – Apr 2024',
      type: '1 Year (Internship + Full-time)',
      description:
          'Completed a 3-month internship followed by a 9-month full-time Flutter developer role, shipping client apps and conducting testing and code reviews.',
      bulletPoints: [
        'Completed 3-month internship followed by a 9-month full-time role.',
        'Developed Flutter mobile applications for client projects across various domains.',
        'Performed debugging, testing, and code reviews to improve application stability.',
        'Collaborated with the development team to deliver production applications to clients.',
      ],
      technologies: ['Flutter', 'Dart', 'REST API', 'Debugging', 'Git', 'Agile'],
      isPresent: false,
    ),
    const ExperienceModel(
      role: 'Android Development Trainee',
      company: 'ATEES Industrial Training Pvt Ltd',
      location: 'Thrissur, Kerala',
      period: 'Nov 2021 – Apr 2022',
      type: '6 Months Training',
      description:
          'Underwent intensive industrial training in mobile development fundamentals, Java programming, Android SDK layout building, and app debugging.',
      bulletPoints: [
        'Learned fundamentals of Android mobile development using Java.',
        'Built practice Android applications and performed debugging tasks.',
        'Applied mobile UI guidelines and object-oriented programming concepts.',
      ],
      technologies: ['Java', 'Android SDK', 'Android Studio', 'OOP', 'Debugging'],
      isPresent: false,
    ),
  ];

  // === Education (from CV) ===
  static final List<EducationModel> education = [
    const EducationModel(
      degree: 'BCA (Bachelor of Computer Applications)',
      institution: 'Chinmaya Mission College, Thrissur',
      university: 'Bharathiar University',
      period: 'Jul 2015 – Aug 2018',
      location: 'Thrissur, Kerala',
      description:
          'Comprehensive degree program focusing on Computer Science, Application Development, Software Engineering, Database Systems, and Object-Oriented Architecture.',
    ),
  ];

  // === Languages ===
  static const List<Map<String, String>> languages = [
    {'name': 'English', 'level': 'Fluent'},
    {'name': 'Malayalam', 'level': 'Native'},
    {'name': 'Tamil', 'level': 'Intermediate'},
  ];
}
