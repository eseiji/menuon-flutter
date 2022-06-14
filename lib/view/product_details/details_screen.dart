import 'package:flutter/material.dart';
// import 'package:food_app/constants.dart';
// import 'package:food_app/screens/details/components/app_bar.dart';
// import 'package:food_app/screens/details/components/body.dart';

import '../components/app_bar.dart';
import 'components/body.dart';

class DetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar(context, 'context', ''),
      body: Body(),
    );
  }
}
