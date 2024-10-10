import 'package:account/provider/transaction_provider.dart';
import 'package:account/screens/edit_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xFFB71C1C), // Dark Red
        title: const Text(
          "VLR PLAYER",
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 25, color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () {
              SystemNavigator.pop();
            },
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(56.0),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'ค้นหารายการ...',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide.none,
                ),
                hintStyle: const TextStyle(
                    color: Colors.grey, fontWeight: FontWeight.bold),
              ),
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
              style: const TextStyle(color: Colors.black),
            ),
          ),
        ),
      ),
      body: Consumer<TransactionProvider>(
        builder: (context, provider, child) {
          final filteredTransactions =
              provider.transactions.where((transaction) {
            return transaction.ingamename
                .toLowerCase()
                .contains(searchQuery.toLowerCase());
          }).toList();

          if (filteredTransactions.isEmpty) {
            return const Center(
              child: Text(
                'ไม่มีรายการ',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            );
          } else {
            return ListView.builder(
              itemCount: filteredTransactions.length,
              itemBuilder: (context, index) {
                var statement = filteredTransactions[index];
                return Card(
                  elevation: 4,
                  margin:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16.0),
                    title: Text(
                      statement.ingamename,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Realname: ${statement.realname}',
                            style: const TextStyle(fontSize: 16)),
                        Text('Team: ${statement.team}',
                            style: const TextStyle(fontSize: 16)),
                        Text('Zone: ${statement.zone}',
                            style: const TextStyle(fontSize: 16)),
                      ],
                    ),
                    leading: CircleAvatar(
                      backgroundColor: const Color(0xFFEF5350), // Lighter Red
                      child: FittedBox(
                        child: Text(
                          statement.ingamename[0], // Show first letter
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    trailing: IconButton(
                      icon: const Icon(
                        Icons.delete,
                        color: Color(0xFFB71C1C), // Dark Red
                      ),
                      onPressed: () {
                        provider.deleteTransaction(statement.keyID);
                      },
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return EditScreen(statement: statement);
                          },
                        ),
                      );
                    },
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
