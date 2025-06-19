import 'package:therapify/res/colors/app_colors.dart';
import 'package:therapify/view/widgets/input_decoration.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class SearchableDropdown extends StatefulWidget {
  SearchableDropdown({
    super.key,
    required this.dropdownItems,
    required this.selectedItem,
    required this.onChanged,
    this.prefixIcon,
    this.hintText,
  });
  final List<dynamic> dropdownItems;
  String? selectedItem;
  final ValueChanged<String?> onChanged;
  Widget? prefixIcon;
  String? hintText;

  @override
  State<SearchableDropdown> createState() => _SearchableDropdownState();
}

class _SearchableDropdownState extends State<SearchableDropdown> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField2<String>(
      isExpanded: true,
      decoration: AppInputDecoration.roundInputDecoration(
        context: context,
        hintText: widget.hintText ?? "Select",
        fillColor: AppColors.getContainerColor(),
        borderColor: AppColors.getContainerColor(),
        prefixIcon: widget.prefixIcon,
      ),
      items: widget.dropdownItems
          .map((item) => DropdownMenuItem<String>(
                value: item,
                child: Text(
                  item,
                  style: Theme.of(context).textTheme.bodyMedium,
                  overflow: TextOverflow.ellipsis,
                ),
              ))
          .toList(),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please select an item';
        }
        return null;
      },
      value: widget.selectedItem,
      onChanged: (newValue) {
        widget.onChanged(newValue);
      },
      buttonStyleData: ButtonStyleData(padding: EdgeInsets.only(bottom: 0.h, top: 0, left: 0, right: 0), height: 26.h),
      iconStyleData: IconStyleData(
        icon: Icon(Icons.arrow_drop_down, color: AppColors.getTextColor2()),
        iconSize: 24,
      ),
      dropdownStyleData: DropdownStyleData(
        maxHeight: 300,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          color: AppColors.getBackgroundColor(),
        ),
        scrollbarTheme: ScrollbarThemeData(
          radius: const Radius.circular(40),
          thickness: WidgetStateProperty.all(3),
          thumbVisibility: WidgetStateProperty.all(true),
          thumbColor: WidgetStatePropertyAll(AppColors.getBorderColor()),
        ),
      ),
      menuItemStyleData: MenuItemStyleData(padding: EdgeInsets.only(left: 15.w, right: 15.w)),
      dropdownSearchData: DropdownSearchData(
        searchController: _searchController,
        searchInnerWidgetHeight: 40,
        searchInnerWidget: widget.dropdownItems.length > 4
            ? Container(
                margin: EdgeInsets.only(top: 15.h, left: 15.w, right: 15.w),
                child: TextFormField(
                  controller: _searchController,
                  decoration: AppInputDecoration.roundInputDecoration(context: context, hintText: "Search for"),
                ),
              )
            : const SizedBox(),
        searchMatchFn: (item, searchValue) {
          return item.value.toString().toLowerCase().contains(searchValue.toLowerCase());
        },
      ),
      //This to clear the search value when you close the menu
      onMenuStateChange: (isOpen) {
        if (!isOpen) {
          _searchController.clear();
        }
      },
    );
  }
}
