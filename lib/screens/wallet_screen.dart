import 'package:flutter/material.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WalletScreen(),
    );
  }
}

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});
  @override
  WalletScreenState createState() => WalletScreenState();
}

class WalletScreenState extends State<WalletScreen> {
  List<Map<String, dynamic>> wallets = [
    {"name": "CompteBancaire", "balance": 1500.00},
    {"name": "Portefeuille Cash", "balance": 300.50},
  ];

  void _addWallet() {
    TextEditingController nameController = TextEditingController();
    TextEditingController balanceController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Ajouter un Wallet"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: "Nom du Wallet"),
              ),
              TextField(
                controller: balanceController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: "Solde Initial"),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Annuler"),
            ),
            TextButton(
              onPressed: () {
                if (nameController.text.isNotEmpty &&
                    balanceController.text.isNotEmpty) {
                  setState(() {
                    wallets.add({
                      "name": nameController.text,
                      "balance": double.tryParse(balanceController.text) ?? 0.0,
                    });
                  });
                  Navigator.pop(context);
                }
              },
              child: Text("Ajouter"),
            ),
          ],
        );
      },
    );
  }

  void _editWallet(int index) {
    TextEditingController nameController =
        TextEditingController(text: wallets[index]["name"]);
    TextEditingController balanceController =
        TextEditingController(text: wallets[index]["balance"].toString());

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Modifier Wallet"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: "Nom du Wallet"),
              ),
              TextField(
                controller: balanceController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: "Solde"),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Annuler"),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  wallets[index]["name"] = nameController.text;
                  wallets[index]["balance"] =
                      double.tryParse(balanceController.text) ?? 0.0;
                });
                Navigator.pop(context);
              },
              child: Text("Modifier"),
            ),
          ],
        );
      },
    );
  }

  void _deleteWallet(int index) {
    setState(() {
      wallets.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Gestion des Wallets")),
      body: ListView.builder(
        itemCount: wallets.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 3,
            margin: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            child: ListTile(
              leading: Icon(Icons.account_balance_wallet, color: Colors.blue),
              title: Text(wallets[index]["name"],
                  style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(
                  "Solde: ${wallets[index]["balance"].toStringAsFixed(2)} XAF"),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addWallet,
        backgroundColor: Colors.blue,
        child: Icon(Icons.add),
      ),
    );
  }
}
