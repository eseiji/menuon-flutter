import 'package:flutter/material.dart';

class ItemCard extends StatelessWidget {
  final String title, shopName, svgSrc;
  final Function press;
  const ItemCard({
    Key? key,
    required this.title,
    required this.shopName,
    required this.svgSrc,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // This size provide you the total height and width of the screen
    Size size = MediaQuery.of(context).size;
    return Center(
      child: Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        // color: const Color(0xFF252A34),
        child: SizedBox(
          width: 150,
          height: 200,
          child: Column(
            children: [
              Container(
                height: 130,
                color: const Color(0xFF252A34),
              ),
              Container(
                height: 70,
                color: Colors.black,
              ),
            ],
          ),
        ),
      ),
    );
  }
  // Widget build(BuildContext context) {
  //   // This size provide you the total height and width of the screen
  //   Size size = MediaQuery.of(context).size;
  //   return Container(
  //     width: 150,
  //     height: 200,
  //     margin: EdgeInsets.only(bottom: 20),
  //     // decoration: BoxDecoration(
  //     //   color: Colors.white,
  //     //   borderRadius: BorderRadius.circular(10),
  //     //   // boxShadow: [
  //     //   //   BoxShadow(
  //     //   //     offset: Offset(0, 4),
  //     //   //     blurRadius: 20,
  //     //   //     color: Color(0xFFB0CCE1).withOpacity(0.32),
  //     //   //   ),
  //     //   // ],
  //     // ),
  //     child: Material(
  //       color: Colors.transparent,
  //       child: InkWell(
  //         // onTap: press,
  //         child: Column(
  //           children: <Widget>[
  //             Container(
  //               height: 130,
  //               margin: EdgeInsets.only(bottom: 15),
  //               // padding: EdgeInsets.all(25),
  //               decoration: const BoxDecoration(
  //                 color: Color(0xFF252A34),
  //                 borderRadius: BorderRadius.only(
  //                   topRight: Radius.circular(10.0),
  //                   topLeft: Radius.circular(10.0),
  //                 ),
  //                 // shape: BoxShape.rectangle,
  //               ),
  //               // child: SvgPicture.asset(
  //               //   svgSrc,
  //               //   width: size.width * 0.18,
  //               //   // size.width * 0.18 means it use 18% of total width
  //               // ),
  //             ),
  //             Container(
  //               decoration: const BoxDecoration(
  //                 color: Colors.white,
  //               ),
  //               child: Column(
  //                 children: [
  //                   Text(title),
  //                   SizedBox(height: 10),
  //                   Text(
  //                     shopName,
  //                     style: TextStyle(fontSize: 12),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }
}
