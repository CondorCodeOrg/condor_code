import 'package:condorcode_admin/presentation/enums/admin_section.dart';
import 'package:condorcode_admin/presentation/logic/auth/auth_notifier.dart';
import 'package:condorcode_admin/presentation/view/pages/home/sections/content_section.dart';
import 'package:condorcode_admin/presentation/view/pages/home/sections/manage_user_section.dart';
import 'package:condorcode_admin/presentation/view/pages/home/sections/profile_section.dart';
import 'package:condorcode_admin/presentation/view/pages/home/widgets/side_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ui_kit/ui_kit.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  AdminSection _selectedSection = AdminSection.courses;

  Future<void> _logout() async {
    await ref.read(authProvider.notifier).logout();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.scaffoldBackground,
      body: SafeArea(
        child: Row(
          children: [
            SideMenu(
              selected: _selectedSection,
              onSelected: (section) =>
                  setState(() => _selectedSection = section),
            ),
            const VerticalDivider(width: 1),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24.0),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 1024),
                    child: _buildSection(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection() {
    switch (_selectedSection) {
      case AdminSection.courses:
        return const ContentSection();
      case AdminSection.users:
        return const ManageUserSection();
      case AdminSection.profile:
        return ProfileSection(onLogout: _logout);
    }
  }
}
