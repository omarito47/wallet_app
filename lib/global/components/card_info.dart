import 'package:flutter/material.dart';
import 'package:wallet_app/global/utils/constant_helper.dart';

class CardInfo extends StatelessWidget {
  final String balance;
  final String cardNumber;
  final String cardType;
  CardInfo({
    super.key,
    required this.balance,
    required this.cardNumber,
    required this.cardType,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * .8,
      height: MediaQuery.of(context).size.height * .2,
      margin: EdgeInsets.all(16.0),
      padding: EdgeInsets.only(
          bottom: ConstantHelper.sizex04,
          right: ConstantHelper.sizex16,
          left: ConstantHelper.sizex16,
          top: ConstantHelper.sizex16),
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(ConstantHelper.sizex16),
        image: DecorationImage(
          image: cardType == 'Visa'
              ? AssetImage("assets/visabackground.jpg")
              : AssetImage("assets/mastercardbackground.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        children: [
          SizedBox(height: ConstantHelper.sizex16),
          Text(
            'My Balance',
            style: TextStyle(
              color: Colors.white,
              fontSize: ConstantHelper.sizex16,
              fontWeight: FontWeight.w100,
            ),
          ),
          SizedBox(height: ConstantHelper.sizex02),
          Text(
            "\$"+balance,
            style: TextStyle(
              color: Colors.white,
              fontSize: ConstantHelper.sizex38,
            ),
          ),
          SizedBox(height: ConstantHelper.sizex16),
          Row(
            children: [
              Expanded(
                child: Text(
                  "**** ${cardNumber.substring(cardNumber.length-4)}",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: ConstantHelper.sizex16,
                  ),
                ),
              ),
              SizedBox(
                height: ConstantHelper.sizex60,
                child: Image.asset(
                  cardType == 'Visa'
                      ? "assets/visa.png"
                      : "assets/mastercard.png",
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
