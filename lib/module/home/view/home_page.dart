import 'package:flutter/material.dart';
import 'package:wallet_app/global/components/app_drawer.dart';
import 'package:wallet_app/global/components/card_info.dart';
import 'package:wallet_app/global/model/card.dart';
import 'package:wallet_app/global/model/transaction.dart';
import 'package:wallet_app/global/utils/constant_helper.dart';
import 'package:wallet_app/module/home/controller/home_controller.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeController _homeController = HomeController();
  List<String> transactions = [
    'Transaction 1',
    'Transaction 2',
    'Transaction 3',
  ];
  List<CardInfoModel> cards = [
    CardInfoModel(
      balance: '15 000.00',
      cardNumber: '**** 7456',
      cardType: 'Visa',
    ),
    CardInfoModel(
      balance: '20 000.00',
      cardNumber: '**** 1234',
      cardType: 'Mastercard',
    ),
    // Add more cards here as needed
  ];
  List<Transaction> staticData = [
    Transaction(
      receiverName: "John",
      amount: 50.0,
      date: DateTime(2022, 1, 15),
    ),
    Transaction(
      receiverName: "Sarah",
      amount: 75.0,
      date: DateTime(2022, 2, 28),
    ),
    Transaction(
      receiverName: "Mike",
      amount: 100.0,
      date: DateTime(2022, 3, 10),
    ),
  ];
  List<String> typesCard = ["Visa", "Mastercard"];
  late String selectedCardType;
  String cardNumber = '';
  String cardType = '';
  String cardBalance = '';
  bool isAddingCard = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      selectedCardType = typesCard[0];
    });
  }

  void showAddCardDialog() {
    showDialog(
      context: context,
      builder: (_) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: Text('Add Card'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Card Balance',
                      ),
                      onChanged: (value) {
                        setState(() {
                          cardBalance = value;
                        });
                      },
                    ),
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Card Number',
                      ),
                      onChanged: (value) {
                        setState(() {
                          cardNumber = value;
                        });
                      },
                    ),
                    SizedBox(height: 20),
                    Text('Card Type:'),
                    Column(
                      children: [
                        RadioListTile(
                          title: SizedBox(
                            height: ConstantHelper.sizex60,
                            child: Image.asset("assets/visa.png"),
                          ),
                          value: typesCard[0],
                          groupValue: selectedCardType,
                          onChanged: (value) {
                            setState(() {
                              selectedCardType = value.toString();
                            });
                          },
                        ),
                        RadioListTile(
                          title: SizedBox(
                            height: ConstantHelper.sizex60,
                            child: Image.asset("assets/mastercard.png"),
                          ),
                          value: typesCard[1],
                          groupValue: selectedCardType,
                          onChanged: (value) {
                            setState(() {
                              selectedCardType = value.toString();
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    addNewCard();
                  },
                  child: Text('Save'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void addNewCard() {
    setState(() {
      cards.add(
        CardInfoModel(
          balance: cardBalance,
          cardNumber: cardNumber,
          cardType: selectedCardType,
        ),
      );
    });
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text('My wallet'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * .27,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: cards.length,
              itemBuilder: (context, index) {
                return CardInfo(
                  balance: cards[index].balance,
                  cardNumber: cards[index].cardNumber,
                  cardType: cards[index].cardType,
                );
              },
            ),
          ),
          Flexible(
            child:  ListView.builder(
          itemCount: staticData.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(staticData[index].receiverName),
              subtitle: Text('Amount: ${staticData[index].amount.toStringAsFixed(2)}'),
              trailing: Text('Date: ${staticData[index].date.toString()}'),
            );
          },
        ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: showAddCardDialog,
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
