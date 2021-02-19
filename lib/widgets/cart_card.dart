import 'package:flutter/material.dart';
import 'package:project_shoku/widgets/cart_qty.dart';

class CartCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 70.0,
              width: 100.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("images/foods/ramen_misochasu.jpg"),
                  fit: BoxFit.cover,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 3.0,
                    offset: Offset(0.0, 5.0),
                  ),
                ],
              ),
            ),
            SizedBox(width: 20.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Miso Chasu Ramen",
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5.0),
                Text(
                  "\$ 13.0 ",
                  style: TextStyle(
                      color: Colors.black45,
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5.0),
                Row(
                  children: <Widget>[
                    Container(
                      height: 30.0,
                      width: 80.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        border: Border.all(
                            width: 2.0, color: Theme.of(context).primaryColor),
                      ),
                      child: Center(
                        child: Text(
                          "Remove",
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 15.0),
                        ),
                      ),
                    ),
                    SizedBox(width: 20.0),
                    CartQuantity(),
                  ],
                ),
              ],
            ),
            Spacer(),
            GestureDetector(
              onTap: () {},
              child: Icon(
                Icons.arrow_forward_ios,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
