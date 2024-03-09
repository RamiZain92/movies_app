import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class SpinerBase extends StatelessWidget {
  double? size;
  bool? isStack;

  SpinerBase({Key? key, this.size = 200, this.isStack = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.black,
      body:Center(
        child: LoadingAnimationWidget.staggeredDotsWave(
          color: Colors.amber,
          size: MediaQuery.of(context).size.width * 0.4,
        ),
      ) ,
    ) ;
  }
}
