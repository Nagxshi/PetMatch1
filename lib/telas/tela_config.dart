import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Make sure to import FirebaseAuth
import 'package:petmatch/telas/tela_login.dart'; // Adjust the path for the login screen

class TelaConfigWidget extends StatefulWidget {
  const TelaConfigWidget({super.key});

  @override
  State<TelaConfigWidget> createState() => _PerfilWidgetState();
}

class _PerfilWidgetState extends State<TelaConfigWidget> {
  late PerfilModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = PerfilModel(); // Initialize the model directly
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: SafeArea(
          top: true,
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(
                bottom: 100), // Add extra space at the bottom
            child: Stack(
              children: [
                // Background elements (orange and white containers)
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    width: double.infinity,
                    height: 200,
                    decoration: const BoxDecoration(
                      color: Color(0xFFF4A905),
                    ),
                  ),
                ),
                Positioned(
                  top: 200,
                  left: 0,
                  right: 0,
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(color: Colors.white),
                  ),
                ),
                // Interactive elements (profile options and logout button)
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Align(
                      alignment: AlignmentDirectional.center,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 150),
                        child: Container(
                          width: 350,
                          decoration: BoxDecoration(
                            color: Theme.of(context).cardColor,
                            boxShadow: const [
                              BoxShadow(
                                blurRadius: 14,
                                color: Color(0x33000000),
                                offset: Offset(1, 1),
                                spreadRadius: 1,
                              ),
                            ],
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              _buildProfileOption(
                                context,
                                title: 'Conta',
                                isTopRounded: true,
                              ),
                              _buildProfileOption(
                                context,
                                title: 'Notificações',
                              ),
                              _buildProfileOption(
                                context,
                                title: 'Tema',
                              ),
                              _buildProfileOption(
                                context,
                                title: 'Privacidade & Segurança',
                              ),
                              _buildProfileOption(
                                context,
                                title: 'Ajuda e Suporte',
                              ),
                              _buildProfileOption(
                                context,
                                title: 'Sobre',
                                isBottomRounded: true,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                        height: 24), // Space between options and logout button
                    Container(
                      width: 350,
                      height: 80,
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        boxShadow: const [
                          BoxShadow(
                            blurRadius: 14,
                            color: Color(0x33000000),
                            offset: Offset(1, 1),
                            spreadRadius: 1,
                          ),
                        ],
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              try {
                                // Sign out the user
                                await FirebaseAuth.instance.signOut();
                                // Navigate to the login screen directly
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const TelaLoginWidget(), // Replace with your actual login screen widget
                                  ),
                                );
                              } catch (e) {
                                // Handle any errors here
                                print('Error logging out: $e');
                              }
                            },
                            child: Container(
                              width: 350,
                              height: 80,
                              decoration: BoxDecoration(
                                color: Theme.of(context).cardColor,
                                boxShadow: const [
                                  BoxShadow(
                                    blurRadius: 4,
                                    color: Color(0x33000000),
                                    offset: Offset(0.0, 0.5),
                                  ),
                                ],
                                borderRadius: BorderRadius.circular(24),
                              ),
                              child: const Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.logout_rounded,
                                    color: Color(0xFFFF3438),
                                    size: 24,
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    'Desconectar',
                                    style: TextStyle(
                                      fontFamily: 'Lexend Deca',
                                      color: Color(0xFFFF3438),
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Align(
                      alignment: AlignmentDirectional(-1, 0),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(20, 65, 0, 0),
                        child: Text(
                          'Configurações',
                          style: TextStyle(
                            fontFamily: 'Lexend Deca',
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileOption(BuildContext context,
      {required String title,
      bool isTopRounded = false,
      bool isBottomRounded = false}) {
    return Container(
      width: 350,
      height: 80,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        boxShadow: const [
          BoxShadow(
            blurRadius: 4,
            color: Color(0x33000000),
            offset: Offset(0.0, 0.5),
          ),
        ],
        borderRadius: BorderRadius.only(
          topLeft: isTopRounded ? const Radius.circular(24) : Radius.zero,
          topRight: isTopRounded ? const Radius.circular(24) : Radius.zero,
          bottomLeft: isBottomRounded ? const Radius.circular(24) : Radius.zero,
          bottomRight:
              isBottomRounded ? const Radius.circular(24) : Radius.zero,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
            child: Text(
              title,
              style: const TextStyle(
                fontFamily: 'Lexend Deca',
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 20, 0),
            child: Icon(
              Icons.arrow_forward_ios_rounded,
              color: Theme.of(context).iconTheme.color,
              size: 24,
            ),
          ),
        ],
      ),
    );
  }
}

class PerfilModel {
  void dispose() {
    // Implement disposal logic here if needed
  }
}
