import 'package:flutter/material.dart';
/* import 'package:flutter_svg/flutter_svg.dart'; */
/* import 'package:shop_app/components/default_button.dart'; */

/* import '../../../constants.dart'; */

import '../../components/default_button.dart';

class CheckoutCard extends StatelessWidget {
  const CheckoutCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 15,
        horizontal: 30,
      ),
      // height: 174,
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 0, 0, 0).withOpacity(0.2),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        // boxShadow: [
        //   BoxShadow(
        //     offset: Offset(0, -15),
        //     blurRadius: 20,
        //     color: Color.fromARGB(255, 0, 0, 0).withOpacity(0.15),
        //   )
        // ],
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [],
            ),
            // SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text.rich(
                  TextSpan(
                    text: "Total:\n",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    children: [
                      TextSpan(
                        text: "R\$ 337.15",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: const Color(0xFF5767FE),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black,
                        blurRadius: 15.0,
                      )
                    ],
                  ),
                  child: TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Finalizar pedido',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                // SizedBox(
                //   width: 190,
                //   child: DefaultButton(
                //     text: "Finalizar pedido",
                //     press: () {},
                //   ),
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
