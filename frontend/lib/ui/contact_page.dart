import 'dart:html' as html;

import 'package:flutter/material.dart';
import 'package:portfolio/constants/assets.dart';
import 'package:portfolio/constants/constant_provider_model_objects.dart';
import 'package:portfolio/constants/strings.dart';
import 'package:portfolio/constants/text_styles.dart';
import 'package:portfolio/providers/user_provider.dart';
import 'package:portfolio/routing/route_names.dart';
import 'package:portfolio/utils/screen/screen_utils.dart';
import 'package:portfolio/widgets/responsive_widget.dart';
import 'package:provider/provider.dart';

class ContactPage extends StatefulWidget {
  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<UserProvider>.value(
      value: userProvider,
      child: Consumer<UserProvider>(
        builder: (_, model, ___) => Material(
          color: Color(0xFFF7F8FA),
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: (ScreenUtil.getInstance().setWidth(108))), //144
            child: Scaffold(
              backgroundColor: Colors.transparent,
              appBar: _buildAppBar(context, model),
              drawer: _buildDrawer(context),
              body: LayoutBuilder(builder: (context, constraints) {
                return _buildBody(context, constraints, model);
              }),
            ),
          ),
        ),
      ),
    );
  }

  //AppBar Methods:-------------------------------------------------------------
  Widget _buildAppBar(BuildContext context, UserProvider model) {
    return AppBar(
      titleSpacing: 0.0,
      title: _buildTitle(model),
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      actions:
          !ResponsiveWidget.isSmallScreen(context) ? _buildActions() : null,
    );
  }

  Widget _buildTitle(UserProvider model) {
    return RichText(
      text: TextSpan(
        // Note: Styles for TextSpans must be explicitly defined.
        // Child text spans will inherit styles from parent
        style: TextStyle(
          fontSize: 14.0,
          color: Colors.black,
        ),
        children: <TextSpan>[
          TextSpan(
            text: model.userModel == null
                ? 'N/A'
                : model.userModel.data.userData[0].firstName,
            style: TextStyles.logo,
          ),
          TextSpan(
            text: model.userModel == null
                ? 'N/A'
                : model.userModel.data.userData[0].lastName,
            style: TextStyles.logo.copyWith(
              color: Color(0xFF50AFC0),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildActions() {
    return <Widget>[
      MaterialButton(
        child: Text(
          menu_home,
          style: TextStyles.menu_item,
        ),
        onPressed: () {
          Navigator.pushReplacementNamed(context, HomeRoute);
        },
      ),
      MaterialButton(
        child: Text(
          menu_about,
          style: TextStyles.menu_item,
        ),
        onPressed: () {
          Navigator.pushReplacementNamed(context, AboutRoute);
        },
      ),
      MaterialButton(
        child: Text(menu_contact,
            style: TextStyles.menu_item.copyWith(
              color: Color(0xFF50AFC0),
            )),
        onPressed: () {},
      )
    ];
  }

  Widget _buildDrawer(BuildContext context) {
    return ResponsiveWidget.isSmallScreen(context)
        ? Drawer(
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: _buildActions(),
            ),
          )
        : null;
  }

  //Screen Methods:-------------------------------------------------------------
  Widget _buildBody(
      BuildContext context, BoxConstraints constraints, UserProvider model) {
    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(
                    'https://cdn.discordapp.com/attachments/716387726286651465/717410866651463690/portfolio.png'),
                fit: BoxFit.cover)),
        constraints: BoxConstraints(
            minWidth: constraints.maxWidth, minHeight: constraints.maxHeight),
        child: ResponsiveWidget(
          largeScreen: _buildLargeScreen(context, model),
          mediumScreen: _buildMediumScreen(context, model),
          smallScreen: _buildSmallScreen(context, model),
        ),
      ),
    );
  }

  Widget _buildLargeScreen(BuildContext context, UserProvider model) {
    return IntrinsicHeight(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(
            model.userModel.data.userData[0].about.bio,
            style: TextStyles.sub_heading,
          ),
          Expanded(
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                _buildIllustration(),
                Expanded(flex: 1, child: _buildContent(context, model)),
              ],
            ),
          ),
          _buildFooter(context)
        ],
      ),
    );
  }

  Widget _buildMediumScreen(BuildContext context, UserProvider model) {
    return IntrinsicHeight(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Expanded(flex: 1, child: _buildContent(context, model)),
              ],
            ),
          ),
          _buildFooter(context)
        ],
      ),
    );
  }

  Widget _buildSmallScreen(BuildContext context, UserProvider model) {
    return IntrinsicHeight(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Expanded(flex: 1, child: _buildContent(context, model)),
          Divider(),
          _buildCopyRightText(context),
          SizedBox(
              height: ResponsiveWidget.isSmallScreen(context) ? 12.0 : 0.0),
          _buildSocialIcons(),
          SizedBox(
              height: ResponsiveWidget.isSmallScreen(context) ? 12.0 : 0.0),
        ],
      ),
    );
  }

  // Body Methods:--------------------------------------------------------------
  Widget _buildIllustration() {
    return CircleAvatar(
      backgroundColor: Colors.blue,
      minRadius: ScreenUtil.pixelRatio,
      maxRadius: ScreenUtil.getInstance().setWidth(150),
      backgroundImage: NetworkImage(Assets.user_profile),
//      child: Image.network(
//        Assets.user_profile,
//        height: ScreenUtil.getInstance().setWidth(345), //480.0
//      ),
    );
  }

  Widget _buildContent(BuildContext context, UserProvider model) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: ResponsiveWidget.isSmallScreen(context) ? 24.0 : 0.0),
        SizedBox(height: 4.0),
        SizedBox(height: ResponsiveWidget.isSmallScreen(context) ? 12.0 : 24.0),
        SizedBox(height: ResponsiveWidget.isSmallScreen(context) ? 24.0 : 48.0),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 24.0),
          ],
        )
      ],
    );
  }

  // Footer Methods:------------------------------------------------------------
  Widget _buildFooter(BuildContext context) {
    return Column(
      children: <Widget>[
        Divider(),
        Padding(
          padding: EdgeInsets.all(12.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Align(
                child: _buildCopyRightText(context),
                alignment: Alignment.centerLeft,
              ),
              Align(
                child: _buildSocialIcons(),
                alignment: Alignment.centerRight,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCopyRightText(BuildContext context) {
    return Text(
      rights_reserved,
      style: TextStyles.body1.copyWith(
        fontSize: ResponsiveWidget.isSmallScreen(context) ? 8 : 10.0,
      ),
    );
  }

  Widget _buildSocialIcons() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        GestureDetector(
          onTap: () {
            html.window
                .open("https://www.linkedin.com/in/vishal76342/", "LinkedIn");
          },
          child: Image.network(
            Assets.linkedin,
            color: Color(0xFF45405B),
            height: 20.0,
            width: 20.0,
          ),
        ),
        SizedBox(width: 16.0),
        GestureDetector(
          onTap: () {
            html.window.open("https://github.com/vishal24367", "Github");
          },
          child: Image.network(
            Assets.google,
            color: Color(0xFF45405B),
            height: 20.0,
            width: 20.0,
          ),
        ),
      ],
    );
  }
}
