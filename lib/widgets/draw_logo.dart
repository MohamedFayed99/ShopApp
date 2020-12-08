import 'package:flutter/material.dart';

class DrawLogo extends StatelessWidget {
  const DrawLogo({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 50),
      child: Container(
        height: MediaQuery.of(context).size.height*.2,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Image(
              image: AssetImage('images/icons/buyicon.png'),
            ),
            Positioned(
              bottom: 0,
              child: Text('Buy It',style: TextStyle(
                fontSize: 25,
                fontFamily: 'Pacifico',
              ),),
            )
          ],
        ),
      ),
    );
  }
}