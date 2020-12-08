import 'package:finalshopapp/constants.dart';
import 'package:finalshopapp/screens/cart_screen.dart';
import 'package:finalshopapp/screens/login_screen.dart';
import 'package:finalshopapp/widgets/productsView.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  static String id = 'HomeScreen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int tabBarIndex = 0;
  int bottomBarIndex = 0;
  // List<Product> _products;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        DefaultTabController(
          length: 4,
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              bottom: TabBar(
                indicatorColor: kMainColor,
                onTap: (index){
                  setState(() {
                    tabBarIndex = index;
                  });
                },
                tabs: [
                  Text(
                      'Jackets',
                    style: TextStyle(
                      color: tabBarIndex == 0 ? Colors.black : Color(0xFFC1BDBB),
                      fontSize: tabBarIndex == 0 ? 14 : null,
                    ),
                  ),
                  Text('Trousers',
                    style: TextStyle(
                    color: tabBarIndex == 1 ? Colors.black : Color(0xFFC1BDBB),
                    fontSize: 12,
                   ),
                  ),
                  Text(
                      'T-shirts',
                    style: TextStyle(
                      color: tabBarIndex == 2 ? Colors.black : Color(0xFFC1BDBB),
                      fontSize: tabBarIndex == 2 ? 15 : null,
                    ),
                  ),
                  Text(
                      'Shoes',
                    style: TextStyle(
                      color: tabBarIndex == 3 ? Colors.black : kUnActiveColor,
                      fontSize: tabBarIndex == 3 ? 15 : null,
                    ),
                  ),
                ],
              ),
            ),
            body: TabBarView(
              children: [
                ProductsView('jackets'),
                ProductsView('trousers'),
                ProductsView('tshirts'),
                ProductsView('shoes'),

              ],
            ),
            bottomNavigationBar: BottomNavigationBar(
              onTap: (index){
                if(index == 0){
                  Navigator.pushNamed(context, HomeScreen.id);
                }
                if(index == 1){
                  Navigator.pushNamed(context, CartScreen.id);
                  setState(() {
                    index = 0;
                  });

                }
                if(index == 2){
                  FirebaseAuth.instance.signOut();
                  Navigator.popAndPushNamed(context, LoginScreen.id);
                }
                setState(() {
                  bottomBarIndex = index;
                });
              },
              currentIndex: bottomBarIndex,
              fixedColor: kMainColor,
              unselectedItemColor: kUnActiveColor,
              type: BottomNavigationBarType.fixed,
              items: [
                BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: 'Home'
                ),
                BottomNavigationBarItem(
                    icon: Icon(Icons.shopping_cart),
                    label: 'Cart'
                ),
                BottomNavigationBarItem(
                    icon: Icon(Icons.close),
                    label: 'SignOut'
                ),

              ],
            ),
          ),
        ),
        Material(
          child: Padding(
            padding: const EdgeInsets.only(top: 30,left: 20,right: 20,bottom: 0),
            child: Container(
              height: MediaQuery.of(context).size.height*.08,
              width: MediaQuery.of(context).size.width,

              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'discover'.toUpperCase(),
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  GestureDetector(
                      child: Icon(Icons.shopping_cart),
                    onTap: (){
                        Navigator.of(context).pushNamed(CartScreen.id);
                    },
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

}
