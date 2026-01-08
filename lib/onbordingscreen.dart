import 'package:caremall/loginpage.dart';
import 'package:flutter/material.dart';

class OnboardingContent {
  final String title;
  final String description;
  final String imagePath;

  OnboardingContent({
    required this.title,
    required this.description,
    required this.imagePath,
  });
}

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  final List<OnboardingContent> _pages = [
    OnboardingContent(
      title: 'Shop Everything in\nOne Place',
      description:
          'From trendy fashion to the latest electronics, CareMall brings thousands of products to your fingertips.',
      imagePath: 'assets/images/img.png',
    ),
    OnboardingContent(
      title: 'Hassle-Free\nShopping',
      description:
          'Enjoy quick deliveries, safe payments, and easy returns — designed to make your shopping journey smooth and secure.',
      imagePath: 'assets/images/img1.png',
    ),
    OnboardingContent(
      title: 'Deals Made Just\nfor You!!',
      description:
          'Unlock member-only offers, personalized recommendations, and discounts every time you shop.',
      imagePath: 'assets/images/img2.png',
    ),
  ];

  void _navigateToLogin() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const Loginpage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isLastPage = _currentIndex == _pages.length - 1;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: _pages.length,
                onPageChanged: (index) {
                  setState(() => _currentIndex = index);
                },
                itemBuilder: (context, index) => _buildPage(_pages[index]),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 25.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: List.generate(
                      _pages.length,
                      (index) => _buildDot(isActive: _currentIndex == index),
                    ),
                  ),

                  TextButton(
                    onPressed: () {
                      if (isLastPage) {
                        _navigateToLogin();
                      } else {
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      }
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.red,
                      textStyle: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    child: Text(isLastPage ? 'Get Started' : 'Next'),
                  ),

                  Opacity(
                    opacity: isLastPage ? 0.0 : 1.0,
                    child: TextButton(
                      onPressed: isLastPage ? null : _navigateToLogin,
                      child: const Text(
                        'Skip',
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPage(OnboardingContent page) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          ClipRRect(
            borderRadius: BorderRadius.circular(24.0),
            child: Image.asset(
              page.imagePath,
              height: MediaQuery.of(context).size.height * 0.5,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 40),
          Text(
            page.title,
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            page.description,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.grey,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDot({required bool isActive}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.only(right: 8),
      height: 10,
      width: 10,
      decoration: BoxDecoration(
        color: isActive ? Colors.red : Colors.grey.shade300,
        shape: BoxShape.circle,
      ),
    );
  }
}
