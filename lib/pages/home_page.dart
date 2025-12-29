import 'package:flutter/material.dart';
import 'package:todo_app/pages/menu_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.network(
              "https://images.pexels.com/photos/8796478/pexels-photo-8796478.jpeg?cs=srgb&dl=pexels-khairi-ismaik-8796478.jpg&fm=jpg",
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: SafeArea(
              bottom: true,
              top: false,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 60.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Fail in Love with',
                        style: TextStyle(color: Colors.white, fontSize: 36),
                      ),
                      Text(
                        'Coffee in Blissful',
                        style: TextStyle(color: Colors.white, fontSize: 36),
                      ),
                      Text(
                        'Deligth!',
                        style: TextStyle(color: Colors.white, fontSize: 36),
                      ),
                      Padding(
                        padding: const EdgeInsetsGeometry.only(
                          left: 25,
                          right: 25,
                          top: 20,
                        ),
                        child: Text(
                          'Welcome to our cozy coffee corner, where every cup is a deligful for you.',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(25.0),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (_) => const MenuPage()));
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromARGB(
                              255,
                              209,
                              92,
                              45,
                            ), // цвет кнопки
                            foregroundColor: Colors.white, // цвет текста
                            minimumSize: const Size(280, 56), // ширина и высота
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                12,
                              ), // радиус скругления
                            ),
                          ),
                          child: const Text(
                            'Get Started',
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
