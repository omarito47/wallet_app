import 'package:flutter/material.dart';
import 'package:wallet_app/global/utils/constant_helper.dart';

class CustomButton extends StatelessWidget {
  final void Function()? onTap;
  final String text;
  const CustomButton({super.key, required this.onTap, required this.text});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 43, 119, 170),
          borderRadius: BorderRadius.circular(ConstantHelper.sizex08),
        ),
        padding: EdgeInsets.all(ConstantHelper.sizex25),
        margin: EdgeInsets.symmetric(horizontal: ConstantHelper.sizex25),
        child: Center(
          child: Text(
            text,
            style:const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
