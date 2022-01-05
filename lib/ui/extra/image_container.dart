import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:github_app/services/github_api.dart';

class ImageContainer extends StatelessWidget {
  const ImageContainer({
    Key? key,
    this.children = const [],
    this.uriImage,
  }) : super(key: key);

  final List<Widget> children;
  final String? uriImage;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Container(
              color: Colors.grey,
              width: 80,
              height: 80,
              child: (uriImage?.isNotEmpty ?? false)
                  ? Image.network(uriImage!)
                  : null,
            ),
            const SizedBox(
              width: 16,
            ),
            ...children,
          ],
        ),
      ),
    );
  }
}
