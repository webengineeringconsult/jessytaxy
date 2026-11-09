import 'package:flutter/material.dart';

void main() => runApp(JessyTaxiApp());

class JessyTaxiApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'JessyTaxi',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.amber, scaffoldBackgroundColor: Colors.white),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Logo space - will show when you upload logo.png
              Container(
                height: 120,
                child: Image.asset('assets/logo.png', errorBuilder: (c, e, s) => Icon(Icons.local_taxi, size: 90, color: Colors.amber[700])),
              ),
              SizedBox(height: 10),
              Text('JessyTaxi', textAlign: TextAlign.center, style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
              Text('Ride Safe. Ride Smart.', textAlign: TextAlign.center, style: TextStyle(fontSize: 16, color: Colors.grey[700])),
              SizedBox(height: 8),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(color: Colors.amber[100], borderRadius: BorderRadius.circular(20)),
                child: Text('Accra & Tema Only', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => BookingPage())),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.amber, foregroundColor: Colors.black, padding: EdgeInsets.symmetric(vertical: 16), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                child: Text('Book a Ride', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              SizedBox(height: 12),
              OutlinedButton(
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => DriverPage())),
                style: OutlinedButton.styleFrom(padding: EdgeInsets.symmetric(vertical: 16), side: BorderSide(color: Colors.black), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                child: Text('Become a Driver', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BookingPage extends StatefulWidget {
  @override
  _BookingPageState createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  final pickup = TextEditingController();
  final dropoff = TextEditingController();
  String rideType = 'Standard';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Book a Ride'), backgroundColor: Colors.amber, foregroundColor: Colors.black),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Where are you going?', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            SizedBox(height: 16),
            TextField(controller: pickup, decoration: InputDecoration(labelText: 'Pickup Location - e.g. Madina', border: OutlineInputBorder())),
            SizedBox(height: 12),
            TextField(controller: dropoff, decoration: InputDecoration(labelText: 'Drop-off Location - e.g. Tema Community 25', border: OutlineInputBorder())),
            SizedBox(height: 12),
            DropdownButtonFormField<String>(
              value: rideType,
              items: ['Standard', 'Comfort', 'XL'].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
              onChanged: (v) => setState(() => rideType = v!),
              decoration: InputDecoration(labelText: 'Ride Type', border: OutlineInputBorder()),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (pickup.text.isEmpty || dropoff.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please enter pickup and drop-off')));
                  return;
                }
                showDialog(context: context, builder: (_) => AlertDialog(
                  title: Text('Ride Requested!'),
                  content: Text('From: ${pickup.text}\nTo: ${dropoff.text}\nType: $rideType\n\nA driver will contact you soon.'),
                  actions: [TextButton(onPressed: () { Navigator.pop(context); Navigator.pop(context); }, child: Text('OK'))],
                ));
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.amber, foregroundColor: Colors.black, padding: EdgeInsets.symmetric(vertical: 16)),
              child: Text('Confirm Ride', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }
}

class DriverPage extends StatelessWidget {
  final name = TextEditingController();
  final phone = TextEditingController();
  final car = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Become a Driver'), backgroundColor: Colors.black, foregroundColor: Colors.amber),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Join JessyTaxi', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            Text('Drive in Accra & Tema. Earn daily.'),
            SizedBox(height: 16),
            TextField(controller: name, decoration: InputDecoration(labelText: 'Full Name', border: OutlineInputBorder())),
            SizedBox(height: 12),
            TextField(controller: phone, keyboardType: TextInputType.phone, decoration: InputDecoration(labelText: 'Phone / WhatsApp', border: OutlineInputBorder())),
            SizedBox(height: 12),
            TextField(controller: car, decoration: InputDecoration(labelText: 'Car Model - e.g. Toyota Corolla', border: OutlineInputBorder())),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                showDialog(context: context, builder: (_) => AlertDialog(
                  title: Text('Application Received!'),
                  content: Text('Thanks ${name.text}, we will contact you on ${phone.text} soon.'),
                  actions: [TextButton(onPressed: () { Navigator.pop(context); Navigator.pop(context); }, child: Text('OK'))],
                ));
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.amber, foregroundColor: Colors.black, padding: EdgeInsets.symmetric(vertical: 16)),
              child: Text('Submit Application', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }
}
