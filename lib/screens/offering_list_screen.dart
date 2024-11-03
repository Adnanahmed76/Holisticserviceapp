import 'package:flutter/material.dart';
import 'package:mynewearth/screens/edit_screen.dart';
import 'package:provider/provider.dart';
import 'package:mynewearth/provider.dart';

class OfferingListScreen extends StatelessWidget {
  const OfferingListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Offering"),
      ),
      body: Consumer<OfferingProvider>(
        builder: (context, provider, child) {
          return ListView.builder(
            itemCount: provider.offerings.length,
            itemBuilder: (context, index) {
              final offering = provider.offerings[index];
              return Card(
                elevation: 4,
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                
                child: ListTile(
                isThreeLine: true,
                title: Text(offering.practitionerName,style: TextStyle(fontSize: 20),),
                
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(offering.title,style: TextStyle(fontSize: 15),),
                    Text(offering.description,style: TextStyle(fontSize: 15),),
                    Text('Duration: ${offering.duration} • Price: \$${offering.price.toStringAsFixed(2)}',style: TextStyle(fontSize: 15),),
                  ],
                ),
                
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Delete Offering'),
                          content: const Text('Are you sure you want to delete this offering?'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context); // Close dialog
                              },
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () {
                                provider.deleteoffering(index);
                                Navigator.pop(context); // Close dialog
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Offering deleted successfully'),
                                    duration: Duration(seconds: 2),
                                  ),
                                );
                              },
                              child: const Text('Delete', style: TextStyle(color: Colors.red)),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddEditOfferingScreen(
                        offering: offering,
                        index: index,
                      ),
                    ),
                  );
                },
              )
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AddEditOfferingScreen(),
          ),
        ),
      ),
    );
  }
}

