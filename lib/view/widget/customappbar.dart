import 'package:delivery_app/constant/appcolor.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  final Function()? onPressedNotIcon;
  final Function()? onPressedSearchIcon;
  final Function()? onPressedFavIcon;
  final Function(String)? onChanged;
  final TextEditingController myController;
  final String title;

  const CustomAppBar({
    super.key,
    required this.title,
    this.onPressedNotIcon,
    this.onPressedSearchIcon,
    this.onPressedFavIcon,
    this.onChanged,
    required this.myController,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          // Search Field
          Expanded(
            child: TextFormField(
              controller: myController,
              onChanged: onChanged,
              decoration: InputDecoration(
                hintText: title,
                prefixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: onPressedSearchIcon,
                  color: AppColor.primaryColor,
                ),
                filled: true,
                fillColor: Colors.grey[100],
                contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),

          // Favorite Button
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(15),
            ),
            child: IconButton(
              icon: const Icon(Icons.favorite_border),
              color: AppColor.primaryColor,
              onPressed: onPressedFavIcon,
            ),
          ),
        ],
      ),
    );
  }
}



