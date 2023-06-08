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
      title: 'OZ STYLE',
      body: 'The Modern Fashion Way'),
  OnBoardingModel(
      image: 'assets/images/on_boarding_2.jpg',
      title: 'With Our New App ',
      body: 'You Can Shop From Your Home!'),
  OnBoardingModel(
      image: 'assets/images/on_boarding_3.jpg',
      title: 'Here You Can Find Your Best Taste In Clothes',
      body: 'Have Fun Shopping'),
];
