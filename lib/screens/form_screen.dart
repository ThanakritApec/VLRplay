import 'package:account/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:account/provider/transaction_provider.dart';
import 'package:account/models/transactions.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({super.key});

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final formKey = GlobalKey<FormState>();
  final playernameCtl = TextEditingController();
  final realnameCtl = TextEditingController();
  final teamCtl = TextEditingController();
  final zoneCtl = TextEditingController();

  @override
  void dispose() {
    // ทำการลบ TextEditingController เมื่อไม่ใช้งานแล้วเพื่อป้องกัน memory leak
    playernameCtl.dispose();
    realnameCtl.dispose();
    teamCtl.dispose();
    zoneCtl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('แบบฟอร์มเพิ่มข้อมูล'),
        backgroundColor: Colors.red,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'กรอกข้อมูลผู้เล่น',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal,
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Playername',
                  filled: true,
                  fillColor: Colors.red.shade50,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                autofocus: false,
                controller: playernameCtl,
                validator: (String? str) {
                  if (str!.isEmpty) {
                    return 'กรุณากรอกข้อมูล';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Realname',
                  filled: true,
                  fillColor: Colors.teal.shade50,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                autofocus: false,
                controller: realnameCtl,
                validator: (String? str) {
                  if (str!.isEmpty) {
                    return 'กรุณากรอกข้อมูล';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Team',
                  filled: true,
                  fillColor: Colors.teal.shade50,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                autofocus: false,
                controller: teamCtl,
                validator: (String? str) {
                  if (str!.isEmpty) {
                    return 'กรุณากรอกข้อมูล';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Zone',
                  filled: true,
                  fillColor: Colors.teal.shade50,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                autofocus: false,
                controller: zoneCtl,
                validator: (String? str) {
                  if (str!.isEmpty) {
                    return 'กรุณากรอกข้อมูล';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      var statement = Transactions(
                        keyID: null,
                        ingamename: playernameCtl.text,
                        realname: realnameCtl.text,
                        team: teamCtl.text,
                        zone: zoneCtl.text,
                      );
                      var provider = Provider.of<TransactionProvider>(context,
                          listen: false);
                      provider.addTransaction(statement);
                      playernameCtl.clear();
                      realnameCtl.clear();
                      teamCtl.clear();
                      zoneCtl.clear();
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomeScreen(),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal, // สีของปุ่ม
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'บันทึก',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
