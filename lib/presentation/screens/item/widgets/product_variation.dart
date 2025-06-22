import 'package:flutter/material.dart';
import 'package:multi/data/models/item_details_model.dart';

class ProductVariantSelector extends StatefulWidget {
  final List<Attributes> attributes;
  final List<Variations> variants;
  final Variations? initialSelectedVariation;
  final void Function(Variations?) onVariationSelected;

  const ProductVariantSelector({
    super.key,
    required this.attributes,
    required this.variants,
    required this.onVariationSelected,
    this.initialSelectedVariation,
  });

  @override
  State<ProductVariantSelector> createState() => _ProductVariantSelectorState();
}

class _ProductVariantSelectorState extends State<ProductVariantSelector> {
  Map<int, int> selected = {};

  @override
  void initState() {
    super.initState();
    final initial = widget.initialSelectedVariation;
    if (initial?.attributeValueIds != null) {
      for (final valueId in initial!.attributeValueIds!) {
        for (final attr in widget.attributes) {
          for (final val in attr.values) {
            if (val.valueId == valueId) {
              selected[attr.attributeId] = val.valueId;
            }
          }
        }
      }
      WidgetsBinding.instance.addPostFrameCallback((_) {
        widget.onVariationSelected(getSelectedVariation());
      });
    }
  }

  Variations? getSelectedVariation() {
    if (selected.length != widget.attributes.length) return null;

    final selectedIds = selected.values.toList()..sort();

    try {
    return widget.variants.firstWhere((v) {
      final ids = [...?v.attributeValueIds]..sort();
      return ids.length == selectedIds.length &&
          ids.every((id) => selectedIds.contains(id));
    });
  } catch (e) {
    return null;
  }

  
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widget.attributes.map((attr) {
        final selectedId = selected[attr.attributeId];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(attr.attributeName, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: attr.values.map((val) {
                return ChoiceChip(
                  label: Text(val.attributeValue),
                  selected: selectedId == val.valueId,
                  selectedColor: Colors.black,
                  backgroundColor: Colors.grey.shade200,
                  labelStyle: TextStyle(color: selectedId == val.valueId ? Colors.white : Colors.black),
                  onSelected: (_) {
                    setState(() {
                      selected[attr.attributeId] = val.valueId;
                      widget.onVariationSelected(getSelectedVariation());
                    });
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 12),
          ],
        );
      }).toList(),
    );
  }
}
