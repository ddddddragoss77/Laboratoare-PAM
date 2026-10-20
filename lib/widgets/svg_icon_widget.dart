import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SvgIconWidget extends StatelessWidget {
  final String url;
  final double size;
  final Color? color;

  const SvgIconWidget({
    super.key,
    required this.url,
    this.size = 24,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    if (url.isEmpty) {
      return Icon(Icons.star, size: size, color: color ?? Colors.white);
    }

    if (url.endsWith('.svg') || url.contains('.svg?')) {
      return SvgPicture.network(
        url,
        width: size,
        height: size,
        colorFilter: color != null
            ? ColorFilter.mode(color!, BlendMode.srcIn)
            : null,
        placeholderBuilder: (context) => SizedBox(
          width: size,
          height: size,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            color: color ?? Theme.of(context).primaryColor,
          ),
        ),
        errorBuilder: (context, error, stackTrace) => Icon(
          Icons.fitness_center,
          size: size,
          color: color ?? Colors.grey,
        ),
      );
    }

    // Raster or network image fallback
    return Image.network(
      url,
      width: size,
      height: size,
      color: color,
      errorBuilder: (context, error, stackTrace) => Icon(
        Icons.fitness_center,
        size: size,
        color: color ?? Colors.grey,
      ),
    );
  }
}
