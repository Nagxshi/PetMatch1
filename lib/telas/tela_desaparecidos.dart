import 'package:flutter/material.dart';

class TelaDesaparecidosWidget extends StatelessWidget {
  const TelaDesaparecidosWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const PageViewWithLabels();
  }
}

class PageViewWithLabels extends StatefulWidget {
  const PageViewWithLabels({super.key});

  @override
  _PageViewWithLabelsState createState() => _PageViewWithLabelsState();
}

class _PageViewWithLabelsState extends State<PageViewWithLabels> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<String> _pageLabels = [
    'Meus pets',
    'Todos',
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Desaparecidos'),
        backgroundColor: const Color(0xFFF4A905),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Horizontal label navigation
          Container(
            color: const Color(0xFFF4A905),
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _pageLabels.length,
              itemBuilder: (context, index) {
                final isSelected = _currentPage == index;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: TextButton(
                    onPressed: () {
                      _pageController.animateToPage(
                        index,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    },
                    style: TextButton.styleFrom(
                      foregroundColor:
                          isSelected ? Colors.white : Colors.white70,
                      textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    child: Text(_pageLabels[index]),
                  ),
                );
              },
            ),
          ),

          // PageView content
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              itemCount: _pageLabels.length,
              itemBuilder: (context, index) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Conteúdo para a página "${_pageLabels[index]}"',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
