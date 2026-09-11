import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies/utils/utils.dart';

typedef OnSortSelected = void Function(Sorting);

class SortPicker extends ConsumerStatefulWidget {
  final Sorting selectedSort;
  final OnSortSelected onSortSelected;
  const SortPicker({
    required this.selectedSort,
    required this.onSortSelected,
    super.key,
  });
  @override
  ConsumerState<SortPicker> createState() => _SortPickerState();
}

class _SortPickerState extends ConsumerState<SortPicker> {
  Sorting selectedSort = Sorting.aToz;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Spacer(),
        Text(selectedSort.name, style: Theme.of(context).textTheme.labelLarge),
        addHorizontalSpace(16),
        // 2
        PopupMenuButton<Sorting>(
          icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
          // 3
          onSelected: (Sorting value) {
            widget.onSortSelected(value);
          },
          itemBuilder: (BuildContext context) {
            // 4
            return Sorting.values.mapIndexed<PopupMenuItem<Sorting>>((
              int index,
              Sorting sort,
            ) {
              // 5
              return CheckedPopupMenuItem<Sorting>(
                checked: selectedSort == sort,
                value: sort,
                onTap: () {
                  setState(() {
                    selectedSort = sort;
                  });
                },
                child: Text(sort.name),
              );
            }).toList();
          },
        ),
      ],
    );
  }
}
