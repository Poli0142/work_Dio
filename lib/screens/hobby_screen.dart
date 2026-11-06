import 'package:flutter/material.dart';
import '../services/api_service.dart';

class HobbyScreen extends StatefulWidget {
  const HobbyScreen({super.key});

  @override
  State<HobbyScreen> createState() => _HobbyScreenState();
}

class _HobbyScreenState extends State<HobbyScreen> {
  final ApiService _apiService = ApiService();
  Map<String, dynamic>? _hobby; // Изменено на Map, так как API отдает один объект
  bool _isLoading = false;

  Future<void> _fetchHobbies() async {
    setState(() => _isLoading = true);
    try {
      final data = await _apiService.getRandomHobbies();
      setState(() => _hobby = data);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Ошибка: $e')));
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Случайное хобби')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: _isLoading ? null : _fetchHobbies,
              child: _isLoading ? const CircularProgressIndicator() : const Text('Получить хобби'),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: _hobby == null
                  ? const Center(child: Text('Нажмите кнопку, чтобы получить хобби'))
                  : ListView(
                      children: [
                        Card(
                          child: ListTile(
                            leading: const Icon(Icons.star, color: Colors.amber),
                            title: Text(_hobby!['hobby'] ?? 'Неизвестно', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                            subtitle: Text(_hobby!['link'] ?? 'Ссылка отсутствует'),
                          ),
                        ),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }
}