import 'package:flutter/material.dart';

class ImageLoadingIndicator extends StatelessWidget {
  final ImageChunkEvent loadingProgress;

  const ImageLoadingIndicator({Key key, this.loadingProgress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Center(
        child: CircularProgressIndicator(
          value: loadingProgress.expectedTotalBytes != null
              ? loadingProgress.cumulativeBytesLoaded /
                  loadingProgress.expectedTotalBytes
              : null,
        ),
      ),
    );
  }
}
