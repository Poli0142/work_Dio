import 'package:flutter/material.dart';
import '../services/api_service.dart';

class TriviaScreen extends StatefulWidget {
  const TriviaScreen({super.key});

  @override
  State<TriviaScreen> createState() => _TriviaScreenState();
}

class _TriviaScreenState extends State<TriviaScreen> {
  final ApiService _apiService = ApiService();
  Map<String, dynamic>? _fact; // Храним один факт
  bool _isLoading = false;

  Future<void> _fetchTrivia() async {
    setState(() => _isLoading = true);
    try {
      final data = await _apiService.getRandomTrivia();
      // API возвращает список, берем первый элемент
      setState(() => _fact = data.isNotEmpty ? data[0] : null);
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
      appBar: AppBar(title: const Text('Интересные факты')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: _isLoading ? null : _fetchTrivia,
              child: _isLoading ? const CircularProgressIndicator() : const Text('Получить факты'),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: _fact == null
                  ? const Center(child: Text('Нажмите кнопку, чтобы получить факт'))
                  : ListView(
                      children: [
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _fact!['question'] ?? 'Вопрос',
                                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  'Ответ: ${_fact!['answer'] ?? '---'}',
                                  style: const TextStyle(fontSize: 16, color: Colors.green),
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
      ),
    );
  }
}