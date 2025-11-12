import 'package:flutter/material.dart';
import 'fun_fact_model.dart';

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
                fact.category == _selectedMBTI || fact.category == 'All')
            .toList();
      }
    });
  }

  void _shuffleFact() {
    setState(() {
      _currentFactIndex = (_currentFactIndex + 1) % _filteredFacts.length;
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

  void _jumpToFact(int index) {
    if (index >= 0 && index < _filteredFacts.length) {
      setState(() {
        _currentFactIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final FunFact currentFact = _filteredFacts.isNotEmpty
        ? _filteredFacts[_currentFactIndex]
        : allFunFacts[0];

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                _buildHeader(),
                const SizedBox(height: 24.0),
                _buildFilterButton(),
                _buildFilterDropdown(),
                const SizedBox(height: 24.0),
                Center(
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    transitionBuilder: (child, animation) {
                      return FadeTransition(
                        opacity: animation,
                        child: ScaleTransition(
                          scale: animation,
                          child: child,
                        ),
                      );
                    },
                    child: _buildFactCard(currentFact),
                  ),
                ),
                const SizedBox(height: 32.0),
                _buildShuffleButton(),
                const SizedBox(height: 24.0),
                _buildDotsIndicator(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        const SizedBox(height: 24.0),
        ShaderMask(
          blendMode: BlendMode.srcIn,
          shaderCallback: (bounds) => const LinearGradient(
            colors: [Color(0xFF8B5CF6), Color(0xFFEC4899)],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ).createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
          child: const Text(
            "Fun Facts",
            style: TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 8.0),
        Text(
          "Learn interesting psychology insights",
          style: TextStyle(
            fontSize: 16.0,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildFilterButton() {
    final bool isFiltered = _selectedMBTI != 'All';

    final filterGradient = const LinearGradient(
      colors: [Color(0xFF8B5CF6), Color(0xFFEC4899)],
    );

    return GestureDetector(
      onTap: () {
        setState(() {
          _showFilter = !_showFilter;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
        decoration: BoxDecoration(
          gradient: isFiltered ? filterGradient : null,
          color: isFiltered ? null : Colors.white.withAlpha(204),
          borderRadius: BorderRadius.circular(16.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(26),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  Icons.filter_list,
                  color: isFiltered ? Colors.white : Colors.grey[700],
                ),
                const SizedBox(width: 8.0),
                Text(
                  "Filter: $_selectedMBTI",
                  style: TextStyle(
                    color: isFiltered ? Colors.white : Colors.grey[700],
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            Text(
              "${_filteredFacts.length} facts",
              style: TextStyle(
                color: isFiltered ? Colors.white70 : Colors.grey[500],
                fontSize: 14.0,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterDropdown() {
    return Visibility(
      visible: _showFilter,
      child: Container(
        margin: const EdgeInsets.only(top: 8.0),
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Colors.white.withAlpha(242),
          borderRadius: BorderRadius.circular(16.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(38),
              blurRadius: 15,
              offset: const Offset(0, 5),
            )
          ],
        ),
        child: Container(
          constraints: const BoxConstraints(maxHeight: 256.0),
          child: SingleChildScrollView(
            child: Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: mbtiTypes.map((mbti) {
                final bool isSelected = _selectedMBTI == mbti;
                return ElevatedButton(
                  onPressed: () => _handleFilterChange(mbti),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 12.0),
                    backgroundColor:
                        isSelected ? const Color(0xFF8B5CF6) : Colors.grey[100],
                    foregroundColor:
                        isSelected ? Colors.white : Colors.grey[800],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    shadowColor: isSelected
                        ? const Color(0xFF8B5CF6).withAlpha(128)
                        : Colors.transparent,
                    elevation: isSelected ? 5.0 : 0.0,
                  ),
                  child: Text(mbti, style: const TextStyle(fontSize: 14.0)),
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFactCard(FunFact fact) {
    return Container(
      key: ValueKey<String>(fact.title),
      width: double.infinity,
      padding: const EdgeInsets.all(32.0),
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(230),
        borderRadius: BorderRadius.circular(24.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(26),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
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
                  color: fact.gradientColors.first.withAlpha(77),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                )
              ],
            ),
            child: Icon(fact.icon, color: Colors.white, size: 40),
          ),
          const SizedBox(height: 24.0),
          Text(
            fact.title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 22.0,
              fontWeight: FontWeight.w600,
              color: Color(0xFF374151),
            ),
          ),
          const SizedBox(height: 16.0),
          Text(
            fact.fact,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.grey[600],
              height: 1.5,
            ),
          ),
          const SizedBox(height: 24.0),
          Text(
            "${_currentFactIndex + 1} of ${_filteredFacts.length}",
            style: TextStyle(
              fontSize: 14.0,
              color: Colors.grey[400],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShuffleButton() {
    return GestureDetector(
      onTap: _shuffleFact,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF8B5CF6), Color(0xFFEC4899)],
          ),
          borderRadius: BorderRadius.circular(16.0),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF8B5CF6).withAlpha(102),
              blurRadius: 15,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.shuffle, color: Colors.white, size: 20),
            SizedBox(width: 8.0),
            Text(
              "Next Fact",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDotsIndicator() {
    if (_filteredFacts.isEmpty) return const SizedBox.shrink();

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (int index = 0;
            index < (_filteredFacts.length > 10 ? 10 : _filteredFacts.length);
            index++)
          GestureDetector(
            onTap: () => _jumpToFact(index),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              height: 8.0,
              width: index == _currentFactIndex ? 32.0 : 8.0,
              margin: const EdgeInsets.symmetric(horizontal: 4.0),
              decoration: BoxDecoration(
                gradient: index == _currentFactIndex
                    ? const LinearGradient(
                        colors: [Color(0xFF8B5CF6), Color(0xFFEC4899)],
                      )
                    : null,
                color: index == _currentFactIndex ? null : Colors.grey[300],
                borderRadius: BorderRadius.circular(4.0),
              ),
            ),
          ),
        if (_filteredFacts.length > 10)
          Padding(
            padding: const EdgeInsets.only(left: 4.0),
            child: Text(
              "+${_filteredFacts.length - 10}",
              style: TextStyle(
                fontSize: 12.0,
                color: Colors.grey[400],
              ),
            ),
          ),
      ],
    );
  }
}