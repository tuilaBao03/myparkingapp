
// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:myparkingappadmin/app/localization/app_localizations.dart';

class TextFieldCustom extends StatelessWidget {
  final TextEditingController editController;
  final String title;
  final bool isEdit;
  final int? height;
  final FormFieldValidator<String>? validator;

  const TextFieldCustom({
    super.key,
    required this.editController,
    required this.title,
    required this.isEdit,
    this.height,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      
      height: height?.toDouble() ?? 70,
      child: TextFormField(
        enabled: isEdit,
        controller: editController,
        validator: validator, // ✅ THÊM VALIDATION TẠI ĐÂY
        cursorColor: Theme.of(context).colorScheme.primary,
        style: TextStyle(
          color: Theme.of(context).colorScheme.onPrimary,
        ),
        decoration: InputDecoration(
          labelText: AppLocalizations.of(context).translate(title),
          labelStyle: TextStyle(
            color: Theme.of(context).colorScheme.onPrimary,
          ),
          filled: true,
          fillColor: Theme.of(context).colorScheme.surface,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.onPrimary,
              width: 1,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.primary,
              width: 2,
            ),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: Colors.grey.shade400,
              width: 1,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              color: Colors.red,
              width: 1.5,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              color: Colors.red,
              width: 2,
            ),
          ),
        ),
      ),
    );
  }
}

class TextFieldCustom2 extends StatelessWidget {
  final TextEditingController? editController;
  final String title;
  final bool isEdit;
  final int? height;

  // Thêm cho dropdown
  final bool isDropdown;
  final List<String>? dropdownItems;
  final String? selectedValue;
  final Function(String?)? onChanged;

  const TextFieldCustom2({
    super.key,
    this.editController,
    required this.title,
    required this.isEdit,
    this.height,
    this.isDropdown = false,
    this.dropdownItems,
    this.selectedValue,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height?.toDouble() ?? 50,
      child: isDropdown
          ? DropdownButtonFormField<String>(
              value: selectedValue,
              items: dropdownItems
                  ?.map((item) => DropdownMenuItem(
                        value: item,
                        child: Text(item),
                      ))
                  .toList(),
              onChanged: isEdit ? onChanged : null,
              decoration: InputDecoration(
                labelText: title,
                labelStyle: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
                filled: true,
                fillColor: Theme.of(context).colorScheme.surface,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.onPrimary,
                    width: 1,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.primary,
                    width: 2,
                  ),
                ),
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: Colors.grey.shade400,
                    width: 1,
                  ),
                ),
              ),
            )
          : TextFormField(
              enabled: isEdit,
              controller: editController,
              cursorColor: Theme.of(context).colorScheme.primary,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onPrimary,
              ),
              decoration: InputDecoration(
                labelText: title,
                labelStyle: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
                filled: true,
                fillColor: Theme.of(context).colorScheme.surface,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.onPrimary,
                    width: 1,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.primary,
                    width: 2,
                  ),
                ),
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: Colors.grey.shade400,
                    width: 1,
                  ),
                ),
              ),
            ),
    );
  }
}
