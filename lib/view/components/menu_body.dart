import 'package:flutter/material.dart';
// import 'package:shop_app/constants.dart';
// import 'package:shop_app/models/Product.dart';
// import 'package:shop_app/screens/details/details_screen.dart';
import '../../models/ProductMenu.dart';

import '../../constants.dart';
import '../product_detail/details_screen.dart';
import 'categories.dart';
import 'category_item.dart';
import 'item_card2.dart';

class MenuBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff181920),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.all(20),
            padding: const EdgeInsets.symmetric(
              horizontal: 25,
              vertical: 0.0,
            ),
            decoration: BoxDecoration(
              color: const Color(0xFF252A34),
              borderRadius: BorderRadius.circular(10),
              // border: Border.all(
              //   color: const Color(0xFF252A34),
              // ),
            ),
            child: const TextField(
              style: TextStyle(color: Colors.white),
              // onChanged: onChanged,
              decoration: InputDecoration(
                border: InputBorder.none,
                icon: Icon(
                  Icons.search,
                  color: Colors.white,
                ),
                hintText: "Pesquisar",
                hintStyle: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Categories(),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: kDefaultPaddin),
              child: GridView.builder(
                itemCount: products.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: kDefaultPaddin,
                  crossAxisSpacing: kDefaultPaddin,
                  childAspectRatio: 0.75,
                ),
                itemBuilder: (context, index) => ItemCard(
                    product: products[index],
                    press: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailsScreen(
                            product: products[index],
                          ),
                        ),
                      );
                    }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
