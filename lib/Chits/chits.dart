import 'package:companyfoxl/Chits/purchase_chits.dart';
import 'package:flutter/material.dart';

class PurchasedChitsScreen extends StatefulWidget {
  const PurchasedChitsScreen({super.key});

  @override
  State<PurchasedChitsScreen> createState() => _PurchasedChitsScreenState();
}

class _PurchasedChitsScreenState extends State<PurchasedChitsScreen> {
  final List<Map<String, String>> chits = [
    {'title': 'March Chit', 'amount': '1 Lakh chit'},
    {'title': 'May Chit', 'amount': '2 Lakh chit'},
    {'title': 'July Chit', 'amount': '5 Lakh chit'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Purchased Chits',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.notifications,
              color: Colors.white,
            ),
            onPressed: () {},
          ),
        ],
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("images/AfterBG.jpeg"),
                // Replace with your image path
                fit: BoxFit.cover,
              ),
            ),
          ),
          ListView.builder(
            padding: const EdgeInsets.only(top: 100),
            itemCount: chits.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  // Navigate to detail page
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SelectedChit(),
                    ),
                  );
                },
                child: ChitCard(
                  title: chits[index]['title']!,
                  amount: chits[index]['amount']!,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class ChitCard extends StatelessWidget {
  final String title;
  final String amount;

  const ChitCard({super.key, required this.title, required this.amount});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Container(
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.0),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10.0,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              amount,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.blue,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ChitDetailScreen extends StatelessWidget {
  final String title;
  final String amount;

  const ChitDetailScreen(
      {super.key, required this.title, required this.amount});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "Amount: $amount",
              style: const TextStyle(
                fontSize: 24,
                color: Colors.blue,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
