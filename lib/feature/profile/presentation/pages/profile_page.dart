import 'package:app/feature/auth/presentation/bloc/auth_bloc.dart';
import 'package:app/feature/auth/presentation/pages/login_page.dart';
import 'package:app/feature/profile/presentation/widgets/profile_drawer.dart';
import 'package:app/feature/profile/presentation/widgets/profile_stat_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    const String avatarUrl =
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTDl_6Kf7Vu_0QzlMb2LbmULSBH3xdNUuZsag&sg';
    const String name = 'Maksatbek';
    const int level = 3;
    const int xp = 850;
    final List<String> badges = ['🔥', '📚', '🏆'];
    const int mistakes = 5;
    const int completedLessons = 7;

    return BlocListener<AuthBloc, AuthState>(
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
          backgroundColor: Colors.brown.shade700,
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
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(avatarUrl),
              ),
              const SizedBox(height: 10),
              const Text(
                name,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ProfileStatBox(label: 'Level', value: '$level'),
                  ProfileStatBox(label: 'XP', value: '$xp XP'),
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
                children: badges.map((e) => Chip(label: Text(e))).toList(),
              ),
              const SizedBox(height: 30),
              const ListTile(
                leading: Icon(Icons.check_circle_outline),
                title: Text('Lessons Completed: $completedLessons'),
              ),
              const ListTile(
                leading: Icon(Icons.error_outline),
                title: Text('Mistakes: $mistakes'),
              ),
              const Spacer(),
              ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.edit),
                label: const Text('Edit Profile'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.brown,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
