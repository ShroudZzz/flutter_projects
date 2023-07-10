
import 'package:flutter/material.dart';

class LoadingContainer extends StatelessWidget {

  final Widget child;
  final bool isLoading;
  final bool cover;

  const LoadingContainer({super.key, required this.child, required this.isLoading, this.cover = false});

  @override
  Widget build(BuildContext context) {
    return !cover ?
    !isLoading ? child : _loadView
        : Stack(
      children: [
        child,
        isLoading ? _loadView : Container()
      ],
    );
  }

  Widget get _loadView {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
