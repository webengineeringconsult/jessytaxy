import 'package:flutter/material.dart';

void main() {
  runApp(JessyTaxiApp());
}

class JessyTaxiApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jessy Taxi',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.yellow),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String pickup = 'Accra Mall';
  String dropoff = 'Kotoka Airport';
  String rideType = 'Standard';
  double price = 45.0;

  Map<String, double> prices = {
    'Standard': 45.0,
    'Comfort': 70.0,
    'XL': 95.0,
  };

  void updatePrice(String type) {
    setState(() {
      rideType = type;
      price = prices[type]!;
    });
  }

  void bookRide() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Ride Booked! 🚕'),
        content: Text(
          'Jessy Taxi is on the way!\n\nFrom: $pickup\nTo: $dropoff\nRide: $rideType\nPrice: GH₵ ${price.toStringAsFixed(0)}\n\nDriver will call you on 0500720567',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow[700],
        title: Text('🚕 Jessy Taxi', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Ride Safe. Ride Smart.', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            Text('Accra - Tema Only  |  📞 0500720567', style: TextStyle(color: Colors.grey[700])),
            SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(labelText: 'Pickup Location', prefixIcon: Icon(Icons.my_location), border: OutlineInputBorder()),
              onChanged: (v) => pickup = v.isEmpty ? 'Accra Mall' : v,
            ),
            SizedBox(height: 12),
            TextField(
              decoration: InputDecoration(labelText: 'Drop-off Location', prefixIcon: Icon(Icons.location_on), border: OutlineInputBorder()),
              onChanged: (v) => dropoff = v.isEmpty ? 'Kotoka Airport' : v,
            ),
            SizedBox(height: 20),
            Text('Choose Ride Type', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            SizedBox(height: 10),
            Row(
              children: prices.keys.map((type) {
                bool selected = rideType == type;
                return Expanded(
                  child: GestureDetector(
                    onTap: () => updatePrice(type),
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 4),
                      padding: EdgeInsets.symmetric(vertical: 14),
                      decoration: BoxDecoration(
                        color: selected ? Colors.black : Colors.grey[200],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          Text(type, style: TextStyle(color: selected ? Colors.yellow : Colors.black, fontWeight: FontWeight.bold)),
                          Text('GH₵ ${prices[type]!.toStringAsFixed(0)}', style: TextStyle(color: selected ? Colors.white : Colors.black)),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            Spacer(),
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(color: Colors.yellow[100], borderRadius: BorderRadius.circular(12)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Total Price', style: TextStyle(fontSize: 16)),
                  Text('GH₵ ${price.toStringAsFixed(0)}', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
                onPressed: bookRide,
                child: Text('BOOK NOW 🚕', style: TextStyle(color: Colors.yellow, fontSize: 18, fontWeight: FontWeight.bold)),
              ),
            ),
            SizedBox(height: 10),
            Center(child: Text('Built by Web Engineering Consult', style: TextStyle(color: Colors.grey))),
          ],
        ),
      ),
    );
  }
}
