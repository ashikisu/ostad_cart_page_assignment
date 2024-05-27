import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shopping Bag',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const ShoppingBag(),
    );
  }
}

class ShoppingBag extends StatefulWidget {
  const ShoppingBag({super.key});

  @override
  _ShoppingBagState createState() => _ShoppingBagState();
}

class _ShoppingBagState extends State<ShoppingBag> {
  Map<String, int> itemCounts = {
    'Pullover': 1,
    'T-Shirt': 1,
    'Sport Dress': 1,
  };

  Map<String, int> itemPrices = {
    'Pullover': 51,
    'T-Shirt': 30,
    'Sport Dress': 43,
  };

  int getTotalAmount() {
    int total = 0;
    itemCounts.forEach((key, value) {
      total += value * itemPrices[key]!;
    });
    return total;
  }

  void incrementItem(String itemName) {
    setState(() {
      itemCounts[itemName] = itemCounts[itemName]! + 1;
      if (itemCounts[itemName] == 5) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Congratulations!'),
              content: Text('You have added 5 $itemName on your bag!'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('OKAY'),
                ),
              ],
            );
          },
        );
      }
    });
  }

  void decrementItem(String itemName) {
    setState(() {
      if (itemCounts[itemName]! > 1) {
        itemCounts[itemName] = itemCounts[itemName]! - 1;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Bag'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: itemCounts.keys.map((itemName) {
          return Card(
            child: ListTile(
              leading: Image.network("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSWTAPxX3SH13D1w7gqHfxR-pAmgpC9GOy2RH2RqOZejw&s"),
              title: Text(itemName),
              subtitle: const Text('Color: Black\nSize: L'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: () => decrementItem(itemName),
                  ),
                  Text(itemCounts[itemName].toString()),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () => incrementItem(itemName),
                  ),
                  Text('\$${itemPrices[itemName]}'),
                ],
              ),
            ),
          );
        }).toList(),
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Total amount: \$${getTotalAmount()}',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(

                    content: Text('Congratulations You Have added added $itemCounts items'),
                  ),
                );
              },
              child: const Text('CHECK OUT'),
            ),
          ],
        ),
      ),
    );
  }
}
