import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:proto/constants.dart';

class ImgWithDefault extends StatelessWidget {
  const ImgWithDefault({
    Key? key,
    required this.imageDimension,
    required this.url,
  }) : super(key: key);

  final double imageDimension;
  final String url;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: CachedNetworkImage(
        errorWidget: (BuildContext ctx, String word, dynamic anything) {
          return Image.network(Constants.getProductPlaceHolderURL(),
              width: imageDimension, height: imageDimension);
        },
        imageUrl: url,
        width: imageDimension,
        height: imageDimension,
        // color: Colors.pink,
      ),
    );
  }
}
