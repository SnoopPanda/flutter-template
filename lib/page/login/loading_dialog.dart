import 'package:flutter/material.dart';

class LoadingDialog extends Dialog {

  final Widget loadingView;
  final String content;
  final bool showContent;
  final double radius;
  final Color backgroundColor;

  LoadingDialog(
      {Key key,
      this.loadingView,
      this.content = "加载中...",
      this.showContent = true,
      this.radius = 10,
      this.backgroundColor = Colors.white})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Center(
        child: SizedBox(
          width: showContent ? 120 : 80,
          height: showContent ? 120 : 80,
          child: Container(
            decoration: ShapeDecoration(
              color: backgroundColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(radius)
                ),
              )
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                loadingView == null ? CircularProgressIndicator() : loadingView,
                showContent ? Padding(
                  padding: const EdgeInsets.only(top:16,),
                  child: Text(content),
                ) : SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  
}