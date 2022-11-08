import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:jgarden/models/profile_page_model.dart';
import 'package:jgarden/pages/auth/auth_screen.dart';
import 'package:jgarden/pages/services/account_services.dart';
import 'package:jgarden/utils/colors.dart';
import 'package:jgarden/utils/dimensions.dart';
import 'package:jgarden/widgets/customAppBar.dart';
import 'package:provider/provider.dart';
import '../../providers/user_provider.dart';

class ProfileMain extends StatelessWidget {
  const ProfileMain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    const String appBarType = 'profile';
    List<ProfileOption> option = ProfileOption.option;
    return Scaffold(
      appBar: customAppBar(user, appBarType),
      body: Builder(builder: (context) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: Dimensions.height20,
            ),
            ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return InkWell(
                    highlightColor: Colors.white,
                    splashColor: AppColors.mainColor,
                    borderRadius: BorderRadius.circular(Dimensions.radius10),
                    onTap: () {
                      Navigator.pushNamed(context, option[index].routeName);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 25.0, right: 25),
                      child: ProfileOptions(
                        option: option[index].name,
                        icon: option[index].icon,
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return const Divider();
                },
                itemCount: option.length),
            const Divider(),
            InkWell(
              highlightColor: Colors.white,
              splashColor: AppColors.mainColor,
              borderRadius: BorderRadius.circular(Dimensions.radius10),
              onTap: () {
                AccountServices().logOut(context);
              },
              child: const Padding(
                padding: EdgeInsets.only(left: 25.0, right: 25),
                child: ProfileOptions(
                  option: 'Logout',
                  icon: Icon(
                    CupertinoIcons.square_arrow_right,
                    size: 26,
                  ),
                ),
              ),
            )
          ],
        );
      }),
    );
  }
}

class ProfileOptions extends StatelessWidget {
  final String option;
  final Icon icon;
  const ProfileOptions({
    Key? key,
    required this.option,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Dimensions.height55,
      child: Row(
        children: [
          icon,
          SizedBox(
            width: Dimensions.width15,
          ),
          Expanded(
            child: Text(
              option,
              style: const TextStyle(fontSize: 18),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const Icon(
            CupertinoIcons.right_chevron,
            size: 20,
          )
        ],
      ),
    );
  }
}
