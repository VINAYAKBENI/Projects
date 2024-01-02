import 'package:promarketplace/constants/global_variables.dart';
import 'package:promarketplace/constants/utils.dart';
import 'package:promarketplace/features/account/widgets/below_app_bar.dart';
import 'package:promarketplace/features/account/widgets/orders.dart';
import 'package:promarketplace/features/account/widgets/top_buttons.dart';
import 'package:flutter/material.dart';
import 'package:promarketplace/features/search/screens/search_screen.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                alignment: Alignment.topLeft,
                child: Image.asset(
                  'assets/images/promarketplace.png',
                  width: 160,
                  height: 195,
                  //color: Colors.black,
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () => showSnackBar(context, 'To be Added Soon'),
                      child: const Padding(
                        padding: EdgeInsets.only(right: 15),
                        child: Icon(Icons.notifications_outlined),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, SearchScreen.routeName,
                            arguments: " ");
                      },
                      child: const Icon(
                        Icons.search,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      body: const Column(
        children: [
          BelowAppBar(),
          SizedBox(height: 10),
          TopButtons(),
          SizedBox(height: 20),
          Orders(),
        ],
      ),
    );
  }
}
