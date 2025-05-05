import 'package:flutter/material.dart';
import 'package:myparkingappadmin/screens/authentication/components/text_field_custom.dart';

class Search extends StatefulWidget {
  final Function(String) onSearch; // Sửa lại kiểu callback
  const Search({super.key, required this.onSearch});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 5,
          child: TextFieldCustom(
            editController: _searchController,
            title: "Search by name",
            isEdit: true,
          ),
        ),
        Expanded(
          flex: 1,
          child: IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              widget.onSearch(_searchController.text); // Sửa gọi callback
            },
          ),
        ),
      ],
    );
  }
}
