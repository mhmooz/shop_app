class OnBoardingModel {
  final String image;
  final String title;
  final String body;

  OnBoardingModel({
    required this.image,
    required this.title,
    required this.body,
  });
}

List<OnBoardingModel> onBoardingList = [
  OnBoardingModel(
      image: 'assets/images/on_boarding_1.jpg',
      title: 'Screen Title 1',
      body: 'Screen Body 1'),
  OnBoardingModel(
      image: 'assets/images/on_boarding_2.jpg',
      title: 'Screen Title 2',
      body: 'Screen Body 2'),
  OnBoardingModel(
      image: 'assets/images/on_boarding_3.jpg',
      title: 'Screen Title 3',
      body: 'Screen Body 3'),
];
