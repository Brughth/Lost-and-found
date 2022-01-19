import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:lost_and_found/src/authentification/pages/sign_in_page.dart';
import 'package:lost_and_found/src/authentification/pages/sign_up_page.dart';
import 'package:lost_and_found/src/widget/app_button.dart';

//import 'Animation/fadeAnimation.dart';

class Welcome extends StatelessWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          color: Color(0xFF212121),
        ),
        child: ListView(
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipPath(
                  // StarClipper
                  clipper: StarClipper(12),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 150,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          Color(0xFFf99321),
                          Color(0xFFfc5a3b),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 35),
              child: Text(
                'Tu as perdu / trouvé\n un objet ?\n tu es au bon endroit.',
                style: TextStyle(
                  color: Color(0xFFcccccf),
                  fontWeight: FontWeight.bold,
                  fontSize: 33,
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 35),
              child: Text(
                'Une application simple pour trouver vos objets perdus. Inscrit toi et trouve l’objet que tu as perdu ou alors trouve le propriétaire de l’objet que tu as ramassé. ',
                style: TextStyle(
                  color: Colors.white54,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            const SizedBox(height: 70),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35),
              child: AppButton(
                text: "Se Connecter",
                firstColor: const Color(0xFFff7521),
                secondColor: const Color(0xFFffb421),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SignInPage(),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35),
              child: AppButton(
                text: "S'inscrire",
                firstColor: const Color(0xFFffb421),
                secondColor: const Color(0xFFff7521),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SignUpPage(),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
