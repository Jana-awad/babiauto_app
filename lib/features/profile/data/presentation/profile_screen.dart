import 'package:babiauto_app/core/api_client.dart';
import 'package:babiauto_app/core/token_storage.dart';
import 'package:flutter/material.dart';
import 'package:babiauto_app/features/auth/data/auth_repository.dart';
import 'package:babiauto_app/features/auth/presentation/edit_profile_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final AuthRepository _authRepo = AuthRepository(
    apiClient: ApiClient(),
    tokenStorage: TokenStorage(),
  );
  bool _loading = true;
  Map<String, dynamic>? _user;
  String? _error;

  @override
  void initState() {
    super.initState();
    _fetchProfile();
  }

  Future<void> _fetchProfile() async {
    setState(() => _loading = true);
    try {
      final user = await _authRepo.currentUser();
      if (!mounted) return;
      setState(() {
        _user = user;
        _loading = false;
        _error = null;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _error = 'Failed to load profile';
        _loading = false;
      });
    }
  }

  Widget _infoRow(String label, String value) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.lightBlue.shade50,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Text(
            "$label: ",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.lightBlue.shade700,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(fontSize: 16, color: Colors.grey.shade800),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: Text(
          _user?['name'] ?? 'Profile',
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.lightBlue.shade600,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
          ? Center(child: Text(_error!))
          : _user == null
          ? const Center(child: Text('No user data'))
          : RefreshIndicator(
              onRefresh: _fetchProfile,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.all(16),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  elevation: 6,
                  shadowColor: Colors.grey.shade300,
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.lightBlue.shade100,
                          child: Icon(
                            Icons.person,
                            size: 50,
                            color: Colors.lightBlue.shade700,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          _user!['name'] ?? 'No Name',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.lightBlue.shade700,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          _user!['email'] ?? 'No Email',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey.shade700,
                          ),
                        ),
                        const Divider(height: 30, thickness: 1.2),
                        _infoRow("Name", _user!['name'] ?? 'N/A'),
                        _infoRow("Email", _user!['email'] ?? 'N/A'),
                        const SizedBox(height: 30),
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton.icon(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      EditProfileScreen(user: _user!),
                                ),
                              ).then((updatedUser) {
                                if (updatedUser != null) {
                                  setState(() {
                                    _user = updatedUser;
                                  });
                                }
                              });
                            },
                            icon: const Icon(
                              Icons.edit,
                              size: 22,
                              color: Colors.white,
                            ),
                            label: const Text(
                              "Edit Profile",
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.lightBlue.shade700,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              elevation: 5,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton.icon(
                            onPressed: () async {
                              await _authRepo.logout();
                              Navigator.pushReplacementNamed(context, '/login');
                            },
                            icon: const Icon(Icons.logout, size: 22),
                            label: const Text(
                              "Logout",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.lightBlue.shade100,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              elevation: 5,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
