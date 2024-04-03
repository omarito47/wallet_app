import 'package:flutter/material.dart';
import 'package:wallet_app/global/utils/constant_helper.dart';

class CustomButton extends StatelessWidget {
  final void Function()? onTap;
  final String text;
  final Color backgroundColor;
  final String? imagePath;
  const CustomButton({
    super.key,
    required this.onTap,
    required this.text,
    required this.backgroundColor,
    this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(ConstantHelper.sizex08),
        ),
        padding: EdgeInsets.all(ConstantHelper.sizex25),
        margin: EdgeInsets.symmetric(horizontal: ConstantHelper.sizex25),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                text,
                style: const TextStyle(color: Colors.white),
              ),
             
              if (imagePath != null)
                SizedBox(
                    height: ConstantHelper.sizex26,
                    child: Image.asset("$imagePath"))
            ],
          ),
        ),
      ),
    );
  }
}
