import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plasess/core/router/app_route.dart';
import 'package:plasess/core/router/route.dart';
import 'package:plasess/screens/profile/profil_api.dart';
import 'package:plasess/screens/profile/profile_model.dart';

class Profile extends ConsumerStatefulWidget {
  const Profile({super.key});

  @override
  ConsumerState<Profile> createState() => _ProfileState();
}

class _ProfileState extends ConsumerState<Profile> {
  ProfilApi profilApi = ProfilApi();
  ProfileModel? profileModel;
  @override
  void initState() {
    super.initState();
    getProfile();
  }

  Future<void> getProfile() async {
    final user = FirebaseAuth.instance.currentUser;

    final profile = await profilApi.getUserProfile(user!.uid);
    setState(() {
      profileModel = profile.first;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Avatar
            const CircleAvatar(radius: 50, child: Icon(Icons.person, size: 50)),

            const SizedBox(height: 20),

            // Name / Email
            Text(
              profileModel?.name ?? "User Name",
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              profileModel?.email ?? "No Email",
              style: const TextStyle(color: Colors.grey),
            ),

            Text(
              profileModel?.phoneNumber ?? "No Phone Number",
              style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
            ),

            const SizedBox(height: 40),

            // Logout Button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();

                  if (!context.mounted) return;

                  AppRouter.pushNamed(Routes.regester);
                },
                icon: const Icon(Icons.logout),
                label: const Text("Logout"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
