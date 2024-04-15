import 'package:flutter/material.dart';

import 'package:wallet_app/main.dart';

import 'package:wallet_app/global/utils/global.dart';

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
    Transaction(
      receiverName: "Daniel",
      amount: 100.0,
      date: DateTime(2022, 3, 10),
    ),
    Transaction(
      receiverName: "Jhonny",
      amount: 100.0,
      date: DateTime(2022, 3, 10),
    ),
    Transaction(
      receiverName: "Ramsy",
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

  late TextEditingController recipientController;
  late TextEditingController amountController;

  @override
  void initState() {
    super.initState();
    selectedCardType = typesCard[0];
    recipientController = TextEditingController();
    amountController = TextEditingController();
  }

  @override
  void dispose() {
    recipientController.dispose();
    amountController.dispose();
    super.dispose();
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
                      keyboardType: TextInputType.number,
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
                      keyboardType: TextInputType.number,
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

  void transferMoney() {
    showDialog(
      context: context,
      builder: (_) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: Text('Transfer Money'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      keyboardType: TextInputType.number,
                      controller: recipientController,
                      decoration: InputDecoration(
                        labelText: 'Recipient Card',
                      ),
                    ),
                    TextField(
                      controller: amountController,
                      decoration: InputDecoration(
                        labelText: 'Amount',
                      ),
                      keyboardType: TextInputType.number,
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
                    performTransfer();
                  },
                  child: Text('Transfer'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void performTransfer() {
    String recipient = recipientController.text;
    double amount = double.tryParse(amountController.text) ?? 0.0;

    // Perform transfer logic here
    // This is just a UI demonstration, so no actual transfer is happening

    // Add the transaction to the list
    setState(() {
      staticData.add(
        Transaction(
          receiverName: recipient,
          amount: amount,
          date: DateTime.now(),
        ),
      );
    });

    // Close the dialog
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Switch(
              value: themeProvider.selectedMode == ThemeModeOptions.Dark,
              onChanged: (value) {
                if (value) {
                  themeProvider.setThemeMode(ThemeModeOptions.Dark);
                } else {
                  themeProvider.setThemeMode(ThemeModeOptions.Light);
                }
              },
            ),
          ),
        ],
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
            child: ListView.builder(
              itemCount: staticData.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.all(ConstantHelper.sizex10),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(ConstantHelper.sizex16),
                  ),
                  child: Card(
                    elevation: 5,
                    child: ListTile(
                      title: Text(staticData[index].receiverName),
                      subtitle: Text(
                          'Amount: ${staticData[index].amount.toStringAsFixed(2)}'),
                      trailing: Text(
                          'Date: ${staticData[index].date.year}-${staticData[index].date.month}-${staticData[index].date.day}'),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FloatingActionButton(
              onPressed: showAddCardDialog,
              child: Icon(Icons.add),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FloatingActionButton(
              onPressed: transferMoney,
              child: Icon(Icons.attach_money),
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
