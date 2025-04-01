import 'package:app/feature/auth/presentation/bloc/auth_bloc.dart';
import 'package:app/feature/auth/presentation/pages/login_page.dart';
import 'package:app/feature/profile/presentation/widgets/profile_drawer.dart';
import 'package:app/feature/profile/presentation/widgets/profile_stat_box.dart';
import 'package:app/feature/profile/presentation/widgets/proflie_xp.dart';
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
        body: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Padding(
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
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 20),
                        const XPChart(),
                        const SizedBox(height: 20),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ProfileStatBox(label: 'Level', value: '3'),
                            ProfileStatBox(label: 'XP', value: '850 XP'),
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
                          children:
                              badges.map((e) => Chip(label: Text(e))).toList(),
                        ),
                        const SizedBox(height: 30),
                        const ListTile(
                          leading: Icon(Icons.check_circle_outline),
                          title: Text('Lessons Completed: 7'),
                        ),
                        const ListTile(
                          leading: Icon(Icons.error_outline),
                          title: Text('Mistakes: 5'),
                        ),
                        const SizedBox(height: 30),
                        ElevatedButton.icon(
                          onPressed: () {
                            // TODO: Navigate to Edit Page
                          },
                          icon: const Icon(Icons.edit),
                          label: const Text('Edit Profile'),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30, vertical: 12),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}



// import 'package:app/feature/profile/presentation/bloc/profile_bloc.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:app/feature/profile/presentation/widgets/profile_stat_box.dart';
// import 'package:app/feature/profile/presentation/widgets/profile_drawer.dart';

// class ProfilePage extends StatelessWidget {
//   const ProfilePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (_) => sl<ProfileBloc>()..add(const GetProfileDetailsEvent()),
//       child: Scaffold(
//         appBar: AppBar(
//           title: const Text('Profile'),
//           actions: [
//             Builder(
//               builder: (context) => IconButton(
//                 icon: const Icon(Icons.menu),
//                 onPressed: () => Scaffold.of(context).openEndDrawer(),
//               ),
//             ),
//           ],
//         ),
//         endDrawer: const ProfileDrawer(),
//         body: BlocBuilder<ProfileBloc, ProfileState>(
//           builder: (context, state) {
//             if (state is ProfileLoading) {
//               return const Center(child: CircularProgressIndicator());
//             }

//             if (state is ProfileLoaded) {
//               final profile = state.profile;

//               return SingleChildScrollView(
//                 padding: const EdgeInsets.all(16),
//                 child: Column(
//                   children: [
//                     CircleAvatar(
//                       radius: 50,
//                       backgroundImage: NetworkImage(profile.avatarUrl),
//                     ),
//                     const SizedBox(height: 10),
//                     Text(
//                       profile.username,
//                       style: const TextStyle(
//                         fontSize: 22,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     const SizedBox(height: 20),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceAround,
//                       children: [
//                         ProfileStatBox(label: 'Level', value: '${profile.level}'),
//                         ProfileStatBox(label: 'XP', value: '${profile.xp} XP'),
//                       ],
//                     ),
//                     const SizedBox(height: 20),
//                     Align(
//                       alignment: Alignment.centerLeft,
//                       child: Text(
//                         'Achievements:',
//                         style: Theme.of(context).textTheme.titleMedium,
//                       ),
//                     ),
//                     const SizedBox(height: 10),
//                     Wrap(
//                       spacing: 10,
//                       children: profile.achievements
//                           .map((e) => Chip(label: Text(e)))
//                           .toList(),
//                     ),
//                     const SizedBox(height: 20),
//                     ListTile(
//                       leading: const Icon(Icons.check_circle_outline),
//                       title: Text('Lessons Completed: ${profile.lessonsCompleted}'),
//                     ),
//                     ListTile(
//                       leading: const Icon(Icons.error_outline),
//                       title: Text('Mistakes: ${profile.mistakes}'),
//                     ),
//                     const SizedBox(height: 20),
//                     ElevatedButton.icon(
//                       onPressed: () {
//                         // TODO: Open edit page
//                       },
//                       icon: const Icon(Icons.edit),
//                       label: const Text('Edit Profile'),
//                     )
//                   ],
//                 ),
//               );
//             }

//             if (state is ProfileError) {
//               return Center(child: Text(state.message));
//             }

//             return const SizedBox();
//           },
//         ),
//       ),
//     );
//   }
// }
