import 'package:promarketplace/constants/utils.dart';
import 'package:promarketplace/features/account/services/account_services.dart';
import 'package:promarketplace/features/account/widgets/account_button.dart';
import 'package:flutter/material.dart';

class TopButtons extends StatelessWidget {
  const TopButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            AccountButton(
              text: 'Your Orders',
              onTap: () {},
            ),
            AccountButton(
              text: 'Turn Seller',
              onTap: () => showSnackBar(context, 'To be Added Soon'),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            AccountButton(
              text: 'Log Out',
              onTap: () => AccountServices().logOut(context),
            ),
            AccountButton(
              text: 'Your Wish List',
              onTap: () => showSnackBar(context, 'To be Added Soon'),
            ),
          ],
        ),
      ],
    );
  }
}