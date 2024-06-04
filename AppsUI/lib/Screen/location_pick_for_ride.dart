import 'package:flutter/material.dart';

class SearchModal extends StatelessWidget {
  const SearchModal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: true,
      initialChildSize: 1.0,  // Full height
      minChildSize: 0.5,      // Minimum height when dragged down
      maxChildSize: 1.0,      // Maximum height when dragged up
      builder: (BuildContext context, ScrollController scrollController) {
        return SingleChildScrollView(
          controller: scrollController,
          child: Container(
            height: MediaQuery.of(context).size.height,
            padding: const EdgeInsets.all(50),
            child: Column(
              children: [
                TextField(
                  decoration: const InputDecoration(
                    hintText: 'From',
                    labelText: 'From',
                    border: OutlineInputBorder(),
                  ),
                  onTap: () {
                    // Implement the OSM search functionality for "From"
                  },
                ),
                const SizedBox(height: 20),
                TextField(
                  decoration: const InputDecoration(
                    hintText: 'Where',
                    labelText: 'Where',
                    border: OutlineInputBorder(),
                  ),
                  onTap: () {
                    // Implement the OSM search functionality for "Where"
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // Implement what happens when the search is completed
                  },
                  child: const Text('Search'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

void showSearchModal(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return const SearchModal();
    },
  );
}
