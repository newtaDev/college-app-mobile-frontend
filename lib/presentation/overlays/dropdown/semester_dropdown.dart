import 'package:flutter/material.dart';
import 'package:widgets_lib/widgets/cards/src/bordered_box.dart';
import 'package:widgets_lib/widgets/common/custom_dropdown.dart';

import '../../../shared/extensions/extentions.dart';

class SemesterDropdown extends StatefulWidget {
  final void Function(int index, String val) onChange;
  final List<String>? items;
  final String? hintText;
  final int initialIndex;
  const SemesterDropdown({
    super.key,
    required this.onChange,
    required this.items,
    this.hintText,
    this.initialIndex = 0,
  });

  @override
  State<SemesterDropdown> createState() => _SemesterDropdownState();
}

class _SemesterDropdownState extends State<SemesterDropdown> {
  late String _dropdownValue;
  @override
  void initState() {
    _dropdownValue = widget.hintText ?? widget.items![widget.initialIndex];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return CustomDropdownButton<String>(
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(20),
        bottomRight: Radius.circular(20),
      ),
      icon: BorderedBox(
        alignment: null,
        child: ConstrainedBox(
          constraints: const BoxConstraints(minWidth: 120),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.arrow_drop_down_rounded,
                color: Colors.grey,
              ),
              Text(
                '$_dropdownValue${int.parse(_dropdownValue).getRankPosition} semester',
                style: textTheme.bodyMedium?.copyWith(color: Colors.black),
              ),
            ],
          ),
        ),
      ),
      dropdownPositionMargin: const EdgeInsets.only(top: 50),
      useIconAsMain: true,
      dropdownColor: Colors.white,
      margin: EdgeInsets.zero,
      elevation: 16,
      style: const TextStyle(color: Colors.white, fontSize: 24),
      underline: const ColoredBox(color: Colors.transparent),
      onChanged: (value) {},
      iconEnabledColor: Colors.white,
      items: List.generate(
        widget.items!.length,
        (index) => CustomDropdownMenuItem<String>(
          value: '',
          alignment: Alignment.center,
          onTap: () {
            setState(() {
              _dropdownValue = widget.items![index];
            });
            widget.onChange(index, widget.items![index]);
          },
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Text(
                '${widget.items![index]}${int.parse(widget.items![index]).getRankPosition} sem',
                style: _dropdownValue == widget.items![index]
                    ? textTheme.titleSmall?.copyWith(color: Colors.black)
                    : textTheme.bodyMedium?.copyWith(color: Colors.black),
              ),
              const SizedBox(
                height: 10,
              ),
              if (index != (widget.items!.length - 1)) const Divider(height: 1)
            ],
          ),
        ),
      ),
    );
  }
}
