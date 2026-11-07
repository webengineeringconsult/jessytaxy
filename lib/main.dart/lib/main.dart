import 'package:flutter/material.dart';

void main() {
  runApp(const JessyTaxiApp());
}

class JessyTaxiApp extends StatelessWidget {
  const JessyTaxiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'JessyTaxi',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF0B1D3A),
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Roboto',
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String pickup = 'East Legon, Accra';
  String dropoff = 'Kotoka Airport (ACC)';
  String selectedVehicle = 'Comfort';
  int selectedIndex = 0;

  final vehicles = [
    {'name': 'Economy', 'price': 'GH₵ 45', 'time': '4 min', 'desc': 'Affordable everyday rides'},
    {'name': 'Comfort', 'price': 'GH₵ 68', 'time': '3 min', 'desc': 'Extra space & AC'},
    {'name': 'Premium', 'price': 'GH₵ 120', 'time': '5 min', 'desc': 'Luxury & top drivers'},
    {'name': 'XL - 7 Seater', 'price': 'GH₵ 95', 'time': '6 min', 'desc': 'For family & luggage'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(20),
              color: const Color(0xFF0B1D3A),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(color: const Color(0xFFFFC107), borderRadius: BorderRadius.circular(12)),
                    child: const Text('J', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF0B1D3A))),
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('JessyTaxi', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
                        Text('Ride Safe. Ride Smart. Accra & Tema', style: TextStyle(color: Colors.white70, fontSize: 12)),
                      ],
                    ),
                  ),
                  const Icon(Icons.notifications_outlined, color: Colors.white),
                ],
              ),
            ),
            // Map Placeholder
            Container(
              height: 180,
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: const Color(0xFFE8EEF5), borderRadius: BorderRadius.circular(16)),
              child: const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.map, size: 48, color: Color(0xFF0B1D3A)),
                    SizedBox(height: 8),
                    Text('MAP - East Legon to Airport', style: TextStyle(fontWeight: FontWeight.bold)),
                    Text('Live driver tracking coming soon', style: TextStyle(color: Colors.grey)),
                  ],
                ),
              ),
            ),
            // Pickup / Dropoff
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  TextField(
                    decoration: InputDecoration(labelText: 'Pickup', prefixIcon: const Icon(Icons.my_location, color: Colors.green), border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)), hintText: pickup),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    decoration: InputDecoration(labelText: 'Where to?', prefixIcon: const Icon(Icons.location_on, color: Colors.red), border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)), hintText: dropoff),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Align(alignment: Alignment.centerLeft, child: Text('Choose your ride', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: vehicles.length,
                itemBuilder: (context, i) {
                  final v = vehicles[i];
                  final isSelected = selectedVehicle == v['name'];
                  return GestureDetector(
                    onTap: () => setState(() => selectedVehicle = v['name']!),
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: isSelected ? const Color(0xFFFFF8E1) : Colors.white,
                        border: Border.all(color: isSelected ? const Color(0xFFFFC107) : Colors.grey.shade300, width: 2),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.local_taxi, size: 36, color: Color(0xFF0B1D3A)),
                          const SizedBox(width: 12),
                          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(v['name']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)), Text(v['desc']!, style: const TextStyle(color: Colors.grey, fontSize: 12)), Text('${v['time']} away', style: const TextStyle(color: Colors.green, fontSize: 12))])),
                          Text(v['price']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFFFC107), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Booking $selectedVehicle - $pickup to $dropoff. Driver finding...')));
                  },
                  child: const Text('BOOK NOW - Request JessyTaxi', style: TextStyle(color: Color(0xFF0B1D3A), fontWeight: FontWeight.bold, fontSize: 16)),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (i) => setState(() => selectedIndex = i),
        selectedItemColor: const Color(0xFF0B1D3A),
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'Trips'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
