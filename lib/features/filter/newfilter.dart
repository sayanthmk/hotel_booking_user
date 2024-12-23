import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MultiFilterProductsPage extends StatefulWidget {
  const MultiFilterProductsPage({super.key});

  @override
  State<MultiFilterProductsPage> createState() =>
      _MultiFilterProductsPageState();
}

class _MultiFilterProductsPageState extends State<MultiFilterProductsPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<String> selectedCategories = [];
  List<String> selectedHotelTypes = [];
  bool coupleFriendly = true;
  bool parkingFacility = true;

  final List<String> categories = ["chennai", "Fashion", "Books", "Home"];
  final List<String> hotelTypes = ["2014", "2016", "Hotel", "Resort"];

  // List to store filtered products
  List<Map<String, dynamic>> _filteredProducts = [];

  // Fetch products with filters
  Future<void> fetchFilteredProducts() async {
    try {
      Query query = _firestore.collection('approved_hotels');

      // Apply category filters if selected
      if (selectedCategories.isNotEmpty) {
        query = query.where('city', whereIn: selectedCategories);
      }

      // Apply hotel type filters if selected
      if (selectedHotelTypes.isNotEmpty) {
        query = query.where('Booking_since', whereIn: selectedHotelTypes);
      }

      // Apply initial boolean filter (isAvailable = true)
      if (coupleFriendly) {
        query = query.where('couple_friendly', isEqualTo: true);
      }
      if (parkingFacility) {
        query = query.where('parking_facility', isEqualTo: true);
      }

      // Execute query and fetch data
      QuerySnapshot querySnapshot = await query.get();

      setState(() {
        _filteredProducts = querySnapshot.docs
            .map((doc) => doc.data() as Map<String, dynamic>)
            .toList();
      });
    } catch (e) {
      // print('Error fetching products: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchFilteredProducts(); // Fetch products initially with isAvailable = true
  }

  // Build Filter Chips
  Widget buildFilterChips(
      List<String> items, List<String> selected, Function(String) onSelected) {
    return Wrap(
      spacing: 10,
      children: items.map((item) {
        return FilterChip(
          label: Text(item),
          selected: selected.contains(item),
          onSelected: (isSelected) {
            setState(() {
              if (isSelected) {
                selected.add(item);
              } else {
                selected.remove(item);
              }
            });
            fetchFilteredProducts(); // Fetch updated results
          },
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Multi-Filter Products"),
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
          const Text("Select Categories:",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          buildFilterChips(categories, selectedCategories,
              (category) => fetchFilteredProducts()),
          const Text("Select Hotel Items:",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          buildFilterChips(hotelTypes, selectedHotelTypes,
              (type) => fetchFilteredProducts()),
          const SizedBox(height: 10),
          BooleanFilterWidget(
            text: 'couplefriendly',
            isAvailable: coupleFriendly,
            onChanged: (value) {
              setState(() {
                coupleFriendly = value;
              });
              fetchFilteredProducts();
            },
          ),
          BooleanFilterWidget(
            text: 'parkingFacility',
            isAvailable: parkingFacility,
            onChanged: (value) {
              setState(() {
                parkingFacility = value;
              });
              fetchFilteredProducts();
            },
          ),
          const Divider(),
          const Text("Filtered Products:",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          Expanded(
            child: _filteredProducts.isEmpty
                ? const Center(child: Text("No Products Found"))
                : ListView.builder(
                    itemCount: _filteredProducts.length,
                    itemBuilder: (context, index) {
                      final product = _filteredProducts[index];
                      return ListTile(
                        title: Text(product['city'] ?? 'No City'),
                        subtitle: Text(
                            'Hotel: ${product['hotel_name'] ?? 'Unknown'}'),
                        trailing: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Pincode: ${product['pincode'] ?? 'N/A'}'),
                            Text(
                                'couple_friendly: ${product['couple_friendly'] == true ? "Yes" : "No"}'),
                            Text(
                                'parking_facility: ${product['parking_facility'] == true ? "Yes" : "No"}'),
                          ],
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
// import 'package:flutter/material.dart';

class BooleanFilterWidget extends StatelessWidget {
  final bool isAvailable;
  final ValueChanged<bool> onChanged;
  final String text;

  const BooleanFilterWidget({
    super.key,
    required this.isAvailable,
    required this.onChanged,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          text,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Switch(
          value: isAvailable,
          onChanged: onChanged, // Call the passed function when toggled
        ),
        Text(isAvailable ? "Yes" : "No"),
      ],
    );
  }
}
// Build Boolean Switch
  // Widget buildBooleanFilter() {
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.center,
  //     children: [
  //       const Text("Show Available Only:",
  //           style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
  //       Switch(
  //         value: coupleFriendly,
  //         onChanged: (value) {
  //           setState(() {
  //             coupleFriendly = value;
  //           });
  //           fetchFilteredProducts();
  //         },
  //       ),
  //       Text(coupleFriendly ? "Yes" : "No"),
  //     ],
  //   );
  // }
           // buildBooleanFilter(), // Boolean toggle filter
          // Use the Custom Boolean Filter Widget