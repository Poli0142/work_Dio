import 'package:flutter/material.dart';
import '../services/api_service.dart';

class CryptoPriceScreen extends StatefulWidget {
  const CryptoPriceScreen({super.key});

  @override
  State<CryptoPriceScreen> createState() => _CryptoPriceScreenState();
}

class _CryptoPriceScreenState extends State<CryptoPriceScreen> {
  final ApiService _apiService = ApiService();
  final TextEditingController _symbolController = TextEditingController(text: 'BTCUSDT');
  String? _price;
  bool _isLoading = false;

  Future<void> _fetchPrice() async {
    setState(() => _isLoading = true);
    try {
      final data = await _apiService.getCryptoPrice(_symbolController.text);
      setState(() {
        _price = data['price']?.toString();
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Ошибка: $e')));
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Курс криптовалют')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _symbolController,
              decoration: const InputDecoration(
                labelText: 'Символ (например, BTCUSDT)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _isLoading ? null : _fetchPrice,
              child: _isLoading ? const CircularProgressIndicator() : const Text('Узнать цену'),
            ),
            const SizedBox(height: 24),
            if (_price != null)
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text('Цена: $_price', style: const TextStyle(fontSize: 20)),
                ),
              ),
          ],
        ),
      ),
    );
  }
}