import 'package:flutter/material.dart';

class StarRatingVisualizer extends StatelessWidget {
  final double? rating;
  final double starSize;
  StarRatingVisualizer({required this.starSize, this.rating});

  @override
  Widget build(BuildContext context) {
    return (this.rating == null)
        ? const SizedBox(
            height: 0.0,
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              (this.rating! >= 1.0)
                  ? Image.asset('assets/rating/star_filled.png')
                  : (this.rating! > 0.5)
                      ? Image.asset('assets/rating/star_half.png')
                      : Image.asset('assets/rating/star_empty.png'),
              (this.rating! >= 2.0)
                  ? Image.asset('assets/rating/star_filled.png')
                  : (this.rating! > 1.5)
                      ? Image.asset('assets/rating/star_half.png')
                      : Image.asset('assets/rating/star_empty.png'),
              (this.rating! >= 3.0)
                  ? Image.asset('assets/rating/star_filled.png')
                  : (this.rating! > 2.5)
                      ? Image.asset('assets/rating/star_half.png')
                      : Image.asset('assets/rating/star_empty.png'),
              (this.rating! >= 4.0)
                  ? Image.asset('assets/rating/star_filled.png')
                  : (this.rating! > 3.5)
                      ? Image.asset('assets/rating/star_half.png')
                      : Image.asset('assets/rating/star_empty.png'),
              (this.rating! == 5)
                  ? Image.asset('assets/rating/star_filled.png')
                  : (this.rating! > 4.5)
                      ? Image.asset('assets/rating/star_half.png')
                      : Image.asset('assets/rating/star_empty.png'),
            ],
          );
  }
}
