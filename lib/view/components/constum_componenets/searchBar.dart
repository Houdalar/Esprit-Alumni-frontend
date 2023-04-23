import 'package:flutter/material.dart';

class FacebookSearchBar extends StatefulWidget {
  @override
  FacebookSearchBarState createState() => FacebookSearchBarState();
}

class FacebookSearchBarState extends State<FacebookSearchBar>
    with SingleTickerProviderStateMixin {
  bool _isExpanded = false;
  late AnimationController _animationController;
  late Animation<double> _animation;
  final TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    _textEditingController.dispose();
    super.dispose();
  }

  void _toggleExpand() {
    setState(() {
      _isExpanded = !_isExpanded;

      if (_isExpanded) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (BuildContext context, Widget? child) {
        return SizedBox(
          height: _animation.value * 100,
          child: Stack(
            children: [
              if (_isExpanded)
                Positioned.fill(
                  child: Container(
                    color: Colors.black54,
                    child: GestureDetector(
                      onTap: _toggleExpand,
                      behavior: HitTestBehavior.opaque,
                    ),
                  ),
                ),
              AnimatedPositioned(
                duration: const Duration(milliseconds: 300),
                left: 0,
                right: 0,
                top: _isExpanded ? 0 : 8,
                child: GestureDetector(
                  onTap: _toggleExpand,
                  behavior: HitTestBehavior.opaque,
                  child: Container(
                    height: _isExpanded ? null : 36,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      color: Colors.grey[200],
                    ),
                    child: Row(
                      children: [
                        const SizedBox(width: 8),
                        const Icon(Icons.search),
                        const SizedBox(width: 8),
                        Expanded(
                          child: TextFormField(
                            controller: _textEditingController,
                            decoration: const InputDecoration(
                              hintText: 'Search',
                              border: InputBorder.none,
                            ),
                            onChanged: (String query) {},
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            _textEditingController.clear();
                          },
                        ),
                        const SizedBox(width: 8),
                      ],
                    ),
                  ),
                ),
              ),
              AnimatedPositioned(
                duration: const Duration(milliseconds: 300),
                left: 0,
                right: 0,
                top: _isExpanded ? 56 : 0,
                height: _animation.value * 44,
                child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                    color: Colors.white,
                  ),
                  child: ListView.builder(
                    itemCount: 10, // Replace with actual search result count
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        title: Text('Search Result $index'),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
