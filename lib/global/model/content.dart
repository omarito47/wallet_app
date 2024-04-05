class UnbordingContent {
  String image;
  String title;
  String discription;

  UnbordingContent(
      {required this.image, required this.title, required this.discription});
}

List<UnbordingContent> contents = [
  UnbordingContent(
      title: 'Welcome on MyWallet ',
      image: 'assets/images/wallet.png',
      discription: "Plan your finance any time "),
  UnbordingContent(
      title: 'Transfert money',
      image: 'assets/images/delivery.png',
      discription:
          
          "You can transfer money"),
  UnbordingContent(
      title: 'History of the transaction',
      image: 'assets/images/historique.png',
      discription:
          
          "You can see the history of the transaction"),
];
