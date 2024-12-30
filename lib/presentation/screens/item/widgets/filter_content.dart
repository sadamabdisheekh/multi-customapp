import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi/logic/cubit/items_cubit.dart';
import 'package:multi/presentation/widgets/primary_button.dart';

class FilterContent extends StatefulWidget {
  const FilterContent({
    super.key,
    required this.categoryId,
    required this.selectedValues,
  });

  final int categoryId;
  final List<int> selectedValues;

  @override
  State<FilterContent> createState() => _FilterContentState();
}

class _FilterContentState extends State<FilterContent> {
  late List<int> selectedValues;

  @override
  void initState() {
    super.initState();
    // Copy the initial selectedValues from the parent
    selectedValues = List.from(widget.selectedValues);
  }

  @override
  Widget build(BuildContext context) {
    final attributes = context.read<ItemsCubit>().attributes ?? [];
    return Scaffold(
      appBar: AppBar(
        title: const Text("Filter Options"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context), // Close the overlay
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ...attributes.map((attribute) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    attribute.name,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Wrap(
                    spacing: 8.0,
                    children: attribute.values.map<Widget>((value) {
                      return ChoiceChip(
                        label: Text(value.name),
                        selected: selectedValues.contains(value.id),
                        onSelected: (bool isSelected) {
                          setState(() {
                            if (isSelected) {
                              selectedValues.add(value.id);
                            } else {
                              selectedValues.remove(value.id);
                            }
                          });
                        },
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 16),
                ],
              );
            }),
            const Spacer(),
            Row(
              children: [
                Expanded(
                  child: PrimaryButton(
                    borderRadius: 16,
                    buttonColor: Theme.of(context).cardColor,
                    borderColor: Colors.black,
                    textColor: Colors.black,
                    onPressed: () {
                      setState(() {
                        selectedValues.clear();
                      });
                    },
                    text: 'Clear Filters',
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: PrimaryButton(
                    onPressed: () {
                      // Apply filters logic
                      debugPrint('Selected Filters: $selectedValues');
                      widget.selectedValues.clear();
                      widget.selectedValues.addAll(selectedValues);
                      context.read<ItemsCubit>().getItems({
                        "categoryId": widget.categoryId,
                        "attributeValueIds": selectedValues,
                      });
                      Navigator.pop(context);
                    },
                    borderRadius: 16,
                    text: 'Apply',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
