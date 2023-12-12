import 'package:desk/base/base_view.dart';
import 'package:desk/provider/invite_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UpgradeMembership extends StatefulWidget {
  @override
  _UpgradeMembershipState createState() => _UpgradeMembershipState();
}

class _UpgradeMembershipState extends State<UpgradeMembership> {





  @override
  void initState() {
    super.initState();

  }

  void dispose() {

    super.dispose();
  }


  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          "Upgrade",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: BaseView<InviteProvider>(
        onModelReady: (provider) {},
        builder: (context, provider, _) => Padding(
          padding: EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Container()
          ),
        ),
      ),
    );
  }
}
