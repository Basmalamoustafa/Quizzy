import 'package:flutter/material.dart';
import '../models/quote_model.dart';
import '../services/api_service.dart';
import '../widgets/common_widgets.dart'; 

class QuoteGalleryScreen extends StatefulWidget {
  const QuoteGalleryScreen({Key? key}) : super(key: key);

  @override
  _QuoteGalleryScreenState createState() => _QuoteGalleryScreenState();
}

class _QuoteGalleryScreenState extends State<QuoteGalleryScreen> {
  late Future<List<Quote>> quotesFuture;
  List<Quote> quotes = [];
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    quotesFuture = getQuotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: FutureBuilder<List<Quote>>(
            future: quotesFuture,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }

              quotes = snapshot.data!;
              final Quote currentQuote = quotes[_currentIndex];

              return SingleChildScrollView(
                child: Column(
                  children: [
                    const GradientHeader(
                      title: "Quotes Gallery",
                      subtitle: "Swipe through inspiring quotes",
                    ),
                    
                    const SizedBox(height: 24),

                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 400),
                      child: KeyedSubtree(
                        key: ValueKey(currentQuote.text),
                        child: _buildQuoteContent(currentQuote),
                      ),
                    ),

                    const SizedBox(height: 32),

                    GradientActionButton(
                      text: "Next Quote",
                      icon: Icons.arrow_forward,
                      onTap: () {
                        setState(() {
                          _currentIndex = (_currentIndex + 1) % quotes.length;
                        });
                      },
                    ),

                    const SizedBox(height: 24),

                    PaginationDots(
                      totalCount: quotes.length,
                      currentIndex: _currentIndex,
                      onDotTap: (index) {
                        setState(() => _currentIndex = index);
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildQuoteContent(Quote quote) {
    return ContentCard(
      child: Column(
        children: [
          const Icon(Icons.format_quote, size: 50, color: Color(0xFF8B5CF6)),
          const SizedBox(height: 16),
          Text(
            quote.text,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 20,
              height: 1.5,
              color: Color(0xFF374151),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            "- ${quote.author}",
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            "${_currentIndex + 1} of ${quotes.length}",
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[400],
            ),
          ),
        ],
      ),
    );
  }
}