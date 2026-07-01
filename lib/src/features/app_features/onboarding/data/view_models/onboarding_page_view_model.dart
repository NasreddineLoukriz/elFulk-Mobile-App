
class OnboardingPageViewModel {
  const OnboardingPageViewModel({
    required this.imagePath,
    required this.title,
    required this.description,
    required this.actionLabel,
    this.isLogoPage = false,
  });

  final String imagePath;
  final String title;
  final String description;
  final String actionLabel;
  final bool isLogoPage;
}

class OnboardingData {
  static const List<OnboardingPageViewModel> pages = [
    OnboardingPageViewModel(
      imagePath: 'assets/icons/elFulk_icon.svg',
      title: '',
      description: '',
      actionLabel: '',
      isLogoPage: true,
    ),
     OnboardingPageViewModel(
      imagePath: 'assets/images/onboarding_image_1.png',
      title: 'عالم آمن يبدأ من هنا',
      description:
           ' الفلك: بيئة رقمية مصممة للأطفال خالية من المحتوى غير المناسب والإعلانات المزعجة.',
      actionLabel: 'ابدأ معنا',
    ),
      OnboardingPageViewModel(
      imagePath: 'assets/images/onboarding_image_2.png',
      title: 'أنت من يقرر، دائمًا',
      description:
          'تحكم فيما يشاهده طفلك، حدد أوقات الاستخدام، وراقب نشاطه بكل سهولة. الفلك يضع القرار في يدك.',
      actionLabel: 'اكتشف المزيد',
    ),
    OnboardingPageViewModel(
      imagePath: 'assets/images/onboarding_image_3.png',
      title: 'تعلّم، العب، اكتشف',
      description:
          'محتوى منتقى بعناية يناسب عمر طفلك ويدعم فضوله بطريقة هادفة. لا عشوائية، لا مفاجآت.',
      actionLabel: 'ابدأ الرحلة',
    ),
  
  
  ];
}
