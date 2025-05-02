import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

void main() {
  timeDilation = 2.5; // Slow motion for Hero animation
  runApp(MaterialApp(home: EventListScreen()));
}

class EventListScreen extends StatefulWidget {
  @override
  _EventListScreenState createState() => _EventListScreenState();
}

class _EventListScreenState extends State<EventListScreen> {
  final List<Map<String, dynamic>> events = [
    {
      'title': 'Movie Premiere',
      'date': '1-May, 2025',
      'image': 'assets/img1.jpg',
      'price': 180.0,
    },
    {
      'title': 'Vintage Car Expo',
      'date': '28-April, 2025',
      'image': 'assets/img2.jpg',
      'price': 1200.0,
    },
    {
      'title': 'Photography Workshop',
      'date': '2-May, 2025',
      'image': 'assets/img3.jpg',
      'price': 205.0,
    },
  ];

  final List<Map<String, dynamic>> bookedEvents = [];

  void bookEvent(Map<String, dynamic> event) {
    setState(() => bookedEvents.add(event));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${event['title'] as String} added to bookings')),
    );
  }

  void removeBooking(int index) {
    setState(() => bookedEvents.removeAt(index));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Events'),
        backgroundColor: const Color.fromARGB(255, 119, 161, 161),
        actions: [
          Stack(
            children: [
              IconButton(
                icon: Icon(Icons.bookmark),
                onPressed:
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (_) => BookingScreen(
                              bookings: bookedEvents,
                              onRemove: removeBooking,
                            ),
                      ),
                    ),
              ),
              if (bookedEvents.isNotEmpty)
                Positioned(
                  right: 8,
                  top: 8,
                  child: CircleAvatar(
                    radius: 8,
                    backgroundColor: Colors.red,
                    child: Text(
                      bookedEvents.length.toString(),
                      style: TextStyle(fontSize: 10, color: Colors.white),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
      backgroundColor: const Color.fromARGB(255, 198, 224, 228),
      body: ListView.builder(
        itemCount: events.length,
        itemBuilder: (context, index) {
          final event = events[index];
          final imagePath = event['image'] as String;
          final title = event['title'] as String;
          final date = event['date'] as String;
          final price = event['price'] as double;

          return ListTile(
            leading: Hero(
              tag: imagePath,
              child: CircleAvatar(
                backgroundImage: AssetImage(imagePath),
                radius: 25,
              ),
            ),
            title: Text(title),
            subtitle: Text('$date\n\$${price.toStringAsFixed(2)}'),
            trailing: IconButton(
              icon: Icon(Icons.add),
              onPressed: () => bookEvent(event),
            ),
            onTap:
                () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (_) => EventDetail(event: event, onBook: bookEvent),
                  ),
                ),
          );
        },
      ),
    );
  }
}

class BookingScreen extends StatelessWidget {
  final List<Map<String, dynamic>> bookings;
  final void Function(int) onRemove;

  BookingScreen({required this.bookings, required this.onRemove});

  @override
  Widget build(BuildContext context) {
    final total = bookings.fold<double>(
      0.0,
      (sum, e) => sum + (e['price'] as double),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Your Bookings'),
        backgroundColor: const Color.fromARGB(255, 119, 161, 161),
      ),
      backgroundColor: Colors.blueGrey[100],
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: bookings.length,
              itemBuilder: (context, index) {
                final event = bookings[index];
                final imagePath = event['image'] as String;
                final title = event['title'] as String;
                final price = event['price'] as double;

                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: AssetImage(imagePath),
                    radius: 30,
                  ),
                  title: Text(title),
                  subtitle: Text('\$${price.toStringAsFixed(2)}'),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => onRemove(index),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Total: \$${total.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}

class EventDetail extends StatelessWidget {
  final Map<String, dynamic> event;
  final void Function(Map<String, dynamic>) onBook;

  EventDetail({required this.event, required this.onBook});

  @override
  Widget build(BuildContext context) {
    final imagePath = event['image'] as String;
    final title = event['title'] as String;
    final date = event['date'] as String;
    final price = event['price'] as double;

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: const Color.fromARGB(255, 119, 161, 161),
      ),
      backgroundColor: Colors.blueGrey[100],
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Center(
          child: Column(
            children: [
              Hero(tag: imagePath, child: Image.asset(imagePath)),
              SizedBox(height: 16),
              Text(
                title,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              Text('Date: $date', style: TextStyle(fontSize: 16)),
              Text(
                'Price: \$${price.toStringAsFixed(2)}',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('$title added to bookings')),
                  );
                  onBook(event);
                },
                child: Text('Book This Event'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
