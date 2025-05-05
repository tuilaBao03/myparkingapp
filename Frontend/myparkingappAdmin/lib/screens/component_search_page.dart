import 'package:flutter/material.dart';
import 'package:myparkingappadmin/app/localization/app_localizations.dart';

class SearchWidget extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSearch;
  final String token;

  const SearchWidget({
    super.key,
    required this.controller,
    required this.onSearch,
    required this.token,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: AppLocalizations.of(context).translate("Finding..."),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            onSubmitted: (_)=>(onSearch)
          ),
        ),
        const SizedBox(width: 8),
        IconButton(
          icon: const Icon(Icons.search, color: Colors.blue),
          onPressed: onSearch,
        ),
      ],
    );
  }
}

class PaginationWidget extends StatelessWidget {
  final int page;
  final int totalPages;
  final VoidCallback onNextPage;
  final VoidCallback onPreviousPage;

  const PaginationWidget({
    Key? key,
    required this.page,
    required this.totalPages,
    required this.onNextPage,
    required this.onPreviousPage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.blue),
          onPressed: page > 1 ? onPreviousPage : null,
        ),
        Text("Page $page of $totalPages"),
        IconButton(
          icon: const Icon(Icons.arrow_forward, color: Colors.blue),
          onPressed: page < totalPages ? onNextPage : null,
        ),
      ],
    );
  }
}

