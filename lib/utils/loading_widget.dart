import 'package:flutter/material.dart';

class AnimatedLoadingWidget extends StatelessWidget {
  const AnimatedLoadingWidget({
    super.key,
    this.isLoading = false,
    required this.child,
    this.loadingMsg,
  });

  final bool isLoading;
  final Widget child;
  final String? loadingMsg;

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: isLoading,
      child: Stack(
        children: [
          AnimatedOpacity(
            opacity: isLoading ? 0.1 : 1,
            duration: const Duration(milliseconds: 200),
            child: child,
          ),
          if (isLoading)
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircularProgressIndicator(),
                  if (loadingMsg != null)
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 16,
                        horizontal: 32,
                      ),
                      child: Text(
                        loadingMsg!,
                        textAlign: TextAlign.center,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    )
                ],
              ),
            )
        ],
      ),
    );
  }
}
