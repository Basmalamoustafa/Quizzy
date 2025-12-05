import 'package:flutter/material.dart';
import '../models/fun_fact_model.dart';
import '../widgets/common_widgets.dart';

class FunFactScreen extends StatefulWidget {
  const FunFactScreen({Key? key}) : super(key: key);

  @override
  _FunFactScreenState createState() => _FunFactScreenState();
}

class _FunFactScreenState extends State<FunFactScreen> {
  String _selectedMBTI = 'All';
  int _currentFactIndex = 0;
  bool _showFilter = false;
  List<FunFact> _filteredFacts = [];

  @override
  void initState() {
    super.initState();
    _updateFilteredFacts();
  }

  void _updateFilteredFacts() {
    setState(() {
      if (_selectedMBTI == 'All') {
        _filteredFacts = List.from(allFunFacts);
      } else {
        _filteredFacts = allFunFacts
            .where((fact) =>
        fact.category == _selectedMBTI ||
            fact.category == 'All')
            .toList();
      }
    });
  }

  void _handleFilterChange(String mbti) {
    setState(() {
      _selectedMBTI = mbti;
      _currentFactIndex = 0;
      _showFilter = false;
      _updateFilteredFacts();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final FunFact currentFact = _filteredFacts.isNotEmpty
        ? _filteredFacts[_currentFactIndex]
        : allFunFacts[0];

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor, // ⭐ FIXED

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const GradientHeader(
                  title: "Fun Facts",
                  subtitle: "Learn interesting psychology insights",
                ),

                const SizedBox(height: 24.0),

                _buildFilterButton(isDark),
                _buildFilterDropdown(isDark),

                const SizedBox(height: 24.0),

                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: _buildFactContent(currentFact, isDark),
                ),

                const SizedBox(height: 32.0),

                GradientActionButton(
                  text: "Next Fact",
                  icon: Icons.shuffle,
                  onTap: () {
                    setState(() {
                      _currentFactIndex =
                          (_currentFactIndex + 1) % _filteredFacts.length;
                    });
                  },
                ),

                const SizedBox(height: 24.0),

                PaginationDots(
                  totalCount: _filteredFacts.length,
                  currentIndex: _currentFactIndex,
                  onDotTap: (index) {
                    if (index < _filteredFacts.length) {
                      setState(() => _currentFactIndex = index);
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFactContent(FunFact fact, bool isDark) {
    return ContentCard(
      padding: const EdgeInsets.all(32),
      child: Column(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: fact.gradientColors,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: fact.gradientColors.first.withOpacity(0.4),
                  blurRadius: 10,
                )
              ],
            ),
            child: Icon(fact.icon, color: Colors.white, size: 40),
          ),
          const SizedBox(height: 24),
          Text(
            fact.title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w600,
              color: isDark ? Colors.white : const Color(0xFF374151),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            fact.fact,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: isDark ? Colors.grey[300] : Colors.grey[600],
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterButton(bool isDark) {
    final bool isFiltered = _selectedMBTI != 'All';

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        gradient: isFiltered
            ? const LinearGradient(
          colors: [Color(0xFF8B5CF6), Color(0xFFEC4899)],
        )
            : null,
        color: isFiltered
            ? null
            : (isDark ? Colors.white10 : Colors.white),
        borderRadius: BorderRadius.circular(16),
      ),
      child: GestureDetector(
        onTap: () => setState(() => _showFilter = !_showFilter),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(Icons.filter_list,
                    color: isFiltered
                        ? Colors.white
                        : (isDark ? Colors.white : Colors.grey[700])),
                const SizedBox(width: 8),
                Text(
                  "Filter: $_selectedMBTI",
                  style: TextStyle(
                    color: isFiltered
                        ? Colors.white
                        : (isDark ? Colors.white : Colors.grey[700]),
                  ),
                ),
              ],
            ),
            Text(
              "${_filteredFacts.length} facts",
              style: TextStyle(
                color: isFiltered
                    ? Colors.white70
                    : (isDark ? Colors.grey[300] : Colors.grey[500]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterDropdown(bool isDark) {
    return Visibility(
      visible: _showFilter,
      child: Container(
        margin: const EdgeInsets.only(top: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isDark ? Colors.white10 : Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Wrap(
          spacing: 8,
          runSpacing: 8,
          children: mbtiTypes.map((mbti) {
            final bool isSelected = _selectedMBTI == mbti;

            return ElevatedButton(
              onPressed: () => _handleFilterChange(mbti),
              style: ElevatedButton.styleFrom(
                backgroundColor:
                isSelected ? const Color(0xFF8B5CF6) : (isDark ? Colors.black26 : Colors.grey[100]),
                foregroundColor:
                isSelected ? Colors.white : (isDark ? Colors.white : Colors.grey[800]),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(mbti),
            );
          }).toList(),
        ),
      ),
    );
  }
}
