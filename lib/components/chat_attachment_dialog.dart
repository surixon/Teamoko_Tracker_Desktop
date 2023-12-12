import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class ChatAttachmentDialog extends StatelessWidget {
  final VoidCallback galleryClick;
  final VoidCallback cameraClick;
  final VoidCallback cancelClick;

  ChatAttachmentDialog(
      { this.galleryClick,  this.cameraClick,  this.cancelClick});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  contentBox(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          width: 300.0,
          padding:
          EdgeInsets.only(left: 8.0, top: 8.0, right: 8.0, bottom: 8.0),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
              boxShadow: [
                BoxShadow(
                    color: Colors.black, offset: Offset(0, 10), blurRadius: 10),
              ]),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                'Choose From',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 12,
              ),
              Divider(
                height: 2.0,
                color: Colors.grey,
              ),
              SizedBox(
                height: 12,
              ),
              GestureDetector(
                onTap: galleryClick,
                child: Text(
                  'File Explorer',
                  style: TextStyle(fontSize: 14, color: Colors.blueAccent),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 12,
              ),
              Divider(
                height: 2.0,
                color: Colors.grey,
              ),

              SizedBox(
                height: 6,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'CANCEL',
                  style: TextStyle(fontSize: 14, color: Colors.black),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 6,
              ),
            ],
          ),
        ), // bottom partpart
      ],
    );
  }
}