import 'dart:io';
import 'package:app/core/common/init/init_auth_dependencies.dart';
import 'package:app/feature/profile/presentation/bloc/profile_state.dart';
import 'package:app/feature/profile/presentation/widgets/proflie_xp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app/core/utils/image_picker_helper.dart';
import 'package:app/feature/auth/presentation/bloc/auth_bloc.dart';
import 'package:app/feature/auth/presentation/pages/login_page.dart';
import 'package:app/feature/profile/domain/entties/user_proflie.dart';
import 'package:app/feature/profile/presentation/bloc/profile_bloc.dart';
import 'package:app/feature/profile/presentation/widgets/profile_drawer.dart';
import 'package:app/feature/profile/presentation/widgets/profile_stat_box.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (_) =>
                sl<ProfileBloc>()..add(const GetProfileDetailsEvent())),
        BlocProvider.value(value: context.read<AuthBloc>()),
      ],
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthInitial) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => const LoginPage()),
              (route) => false,
            );
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Profile'),
            actions: [
              Builder(
                builder: (context) => IconButton(
                  icon: const Icon(Icons.menu),
                  onPressed: () => Scaffold.of(context).openEndDrawer(),
                ),
              ),
            ],
          ),
          endDrawer: const ProfileDrawer(),
          body: BlocBuilder<ProfileBloc, ProfileState>(
            builder: (context, state) {
              if (state is ProfileLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state is ProfileLoaded) {
                final profile = state.profile;

                return SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () => _pickImageFromGallery(context, profile),
                        child: CircleAvatar(
                          radius: 50,
                          backgroundImage: File(profile.avatarUrl).existsSync()
                              ? FileImage(File(profile.avatarUrl))
                              : const AssetImage(
                                      'assets/images/default_avatar.png')
                                  as ImageProvider,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        profile.username,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      const XPChart(),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ProfileStatBox(
                              label: 'Level', value: '${profile.level}'),
                          ProfileStatBox(
                              label: 'XP', value: '${profile.xp} XP'),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Achievements:',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Wrap(
                        spacing: 10,
                        children: profile.achievements
                            .map((e) => Chip(label: Text(e)))
                            .toList(),
                      ),
                      const SizedBox(height: 20),
                      ListTile(
                        leading: const Icon(Icons.check_circle_outline),
                        title: Text(
                            'Lessons Completed: ${profile.lessonsCompleted}'),
                      ),
                      ListTile(
                        leading: const Icon(Icons.error_outline),
                        title: Text('Mistakes: ${profile.mistakes}'),
                      ),
                      const SizedBox(height: 30),
                      // ElevatedButton.icon(
                      //   onPressed: () =>
                      //       _pickImageFromGallery(context, profile),
                      //   icon: const Icon(Icons.image),
                      //   label: const Text('Change Avatar'),
                      // ),
                    ],
                  ),
                );
              }

              if (state is ProfileError) {
                return Center(child: Text(state.message));
              }

              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }

  Future<void> _pickImageFromGallery(
    BuildContext context,
    UserProfileDetailsEntity profile,
  ) async {
    final bloc = context.read<ProfileBloc>();
    final imagePath = await ImagePickerHelper.pickFromGallery();

    if (imagePath != null) {
      final updatedProfile = profile.copyWith(avatarUrl: imagePath);
      bloc.add(UpdateProfileDetailsEvent(updatedProfile));
    }
  }
}
