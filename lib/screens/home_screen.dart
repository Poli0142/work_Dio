import 'package:flutter/material.dart';
import 'crypto_screen.dart';
import 'hobby_screen.dart';
import 'trivia_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('API Ninjas Demo')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildMenuCard(
            context,
            title: 'Курс криптовалют',
            subtitle: 'Узнать текущую цену BTC, ETH и других',
            icon: Icons.monetization_on,
            screen: const CryptoPriceScreen(),
          ),
          _buildMenuCard(
            context,
            title: 'Случайное хобби',
            subtitle: 'Получить идею для нового увлечения',
            icon: Icons.sports_esports,
            screen: const HobbyScreen(),
          ),
          _buildMenuCard(
            context,
            title: 'Интересный факт (Trivia)',
            subtitle: 'Узнать что-то новое и неожиданное',
            icon: Icons.lightbulb_outline,
            screen: const TriviaScreen(),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuCard(BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    required Widget screen,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Icon(icon, size: 40),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => screen),
        ),
      ),
    );
  }
}