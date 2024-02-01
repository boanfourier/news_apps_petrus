import 'package:flutter/material.dart';
import 'package:news_apps_petrus/widgets/web_view.dart';
import 'package:hive_flutter/hive_flutter.dart';

class CardNews extends StatelessWidget {
  final String imagePath;
  final String title;
  final String url;

  CardNews({required this.imagePath, required this.title, required this.url});

  @override
  Widget build(BuildContext context) {
    Hive.openBox<Map>('favorites');
    return Card(
      elevation: 5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Stack(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => WebViewContainer(url: url),
                    ),
                  );
                },
                child: Image.network(
                  imagePath,
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    } else {
                      return CircularProgressIndicator();
                    }
                  },
                ),
              ),
              Positioned(
                top: 8,
                left: 8,
                child: LoveButton(
                  isLoved: false,
                  onTap: () {
                    // Add your favorite logic here
                    Hive.box<Map>('favorites').add({'title': title, 'url': url});
                  },
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class LoveButton extends StatefulWidget {
  final bool isLoved;
  final VoidCallback onTap;

  LoveButton({required this.isLoved, required this.onTap});

  @override
  _LoveButtonState createState() => _LoveButtonState();
}

class _LoveButtonState extends State<LoveButton> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.3).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.reverse();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _controller.forward();
        widget.onTap();
      },
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Icon(
          widget.isLoved ? Icons.favorite : Icons.favorite_border,
          color: widget.isLoved ? Colors.red : null,
          size: 32,
        ),
      ),
    );
  }
}
