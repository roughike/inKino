import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ShowtimeDateSelector extends StatelessWidget {
  ShowtimeDateSelector(this.viewModel);
  final ShowtimesPageViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF0F1633),
        boxShadow: [
          BoxShadow(
            color: Colors.black45,
            blurRadius: 5.0,
            spreadRadius: 2.0,
          ),
        ],
      ),
      height: 56.0,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: viewModel.dates.map((date) {
            return _DateSelectorItem(date, viewModel);
          }).list,
        ),
      ),
    );
  }
}

class _DateSelectorItem extends StatelessWidget {
  _DateSelectorItem(
    this.date,
    this.viewModel,
  );

  final DateTime date;
  final ShowtimesPageViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    final isSelected = date == viewModel.selectedDate;
    final backgroundColor =
        isSelected ? const Color(0xFFF9C243) : const Color(0xFF0F1633);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 100),
      color: backgroundColor,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => viewModel.changeCurrentDate(date),
          radius: 56.0,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: _ItemContent(date, isSelected),
          ),
        ),
      ),
    );
  }
}

class _ItemContent extends StatelessWidget {
  static final dateFormat = DateFormat('E');

  _ItemContent(this.date, this.isSelected);
  final DateTime date;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    final dayColor =
        isSelected ? const Color(0xFF0F1633) : const Color(0xFF717DAD);
    final dateColor = isSelected ? const Color(0xFF0F1633) : Colors.white;
    final dateWeight = isSelected ? FontWeight.w500 : FontWeight.w300;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(height: 10.0),
        AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 100),
          style: TextStyle(
            fontSize: 12.0,
            fontWeight: FontWeight.w500,
            color: dayColor,
          ),
          child: Text(dateFormat.format(date)),
        ),
        AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 100),
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: dateWeight,
            color: dateColor,
          ),
          child: Text(date.day.toString()),
        ),
      ],
    );
  }
}
