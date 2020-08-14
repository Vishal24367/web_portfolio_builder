import 'dart:html' as html;

import 'package:flutter/material.dart';
import 'package:portfolio/constants/assets.dart';
import 'package:portfolio/constants/constant_provider_model_objects.dart';
import 'package:portfolio/constants/fonts.dart';
import 'package:portfolio/constants/strings.dart';
import 'package:portfolio/constants/text_styles.dart';
import 'package:portfolio/models/user_model.dart';
import 'package:portfolio/providers/user_provider.dart';
import 'package:portfolio/routing/route_names.dart';
import 'package:portfolio/utils/screen/screen_utils.dart';
import 'package:portfolio/widgets/responsive_widget.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  final String username;
  const HomePage({Key key, this.username}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  // ignore: must_call_super
  void initState() {
    loadWebsiteData();
  }

  // ignore: always_declare_return_types
  loadWebsiteData() async {
    await userProvider.loadUserDataModel(widget.username);
  }

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
          style: TextStyles.menu_item.copyWith(
            color: Color(0xFF50AFC0),
          ),
        ),
        onPressed: () {},
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
        child: Text(
          menu_contact,
          style: TextStyles.menu_item,
        ),
        onPressed: () {
          Navigator.pushReplacementNamed(context, ContactRoute);
        },
      ),
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
          Expanded(
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Expanded(flex: 1, child: _buildContent(context, model)),
                _buildIllustration(),
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
    return Image.network(
      Assets.programmer3,
      height: ScreenUtil.getInstance().setWidth(345), //480.0
    );
  }

  Widget _buildContent(BuildContext context, UserProvider model) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: ResponsiveWidget.isSmallScreen(context) ? 24.0 : 0.0),
        _builduserMe(context),
        SizedBox(height: 4.0),
        _buildHeadline(context, model),
        SizedBox(height: ResponsiveWidget.isSmallScreen(context) ? 12.0 : 24.0),
        _buildSummary(model),
        SizedBox(height: ResponsiveWidget.isSmallScreen(context) ? 24.0 : 48.0),
        ResponsiveWidget.isSmallScreen(context)
            ? Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _buildEducation(model),
                  SizedBox(height: 24.0),
                  _buildSkills(context, model),
                ],
              )
            : _buildSkillsAndEducation(context, model)
      ],
    );
  }

  Widget _builduserMe(BuildContext context) {
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
            text: about,
            style: TextStyles.heading.copyWith(
              fontFamily: Fonts.nexa_light,
              fontSize: ResponsiveWidget.isSmallScreen(context) ? 36 : 45.0,
            ),
          ),
          TextSpan(
            text: me,
            style: TextStyles.heading.copyWith(
              color: Color(0xFF50AFC0),
              fontSize: ResponsiveWidget.isSmallScreen(context) ? 36 : 45.0,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeadline(BuildContext context, UserProvider model) {
    return Text(
      ResponsiveWidget.isSmallScreen(context)
          ? model.userModel == null
              ? ''
              : model.userModel.data.userData[0].about.bio
          : model.userModel == null
              ? ''
              : model.userModel.data.userData[0].about.bio
                  .replaceFirst(RegExp(r' f'), '\nf'),
      style: TextStyles.sub_heading,
    );
  }

  Widget _buildSummary(UserProvider model) {
    return Padding(
      padding: EdgeInsets.only(right: 80.0),
      child: Text(
        model.userModel == null
            ? 'N/A'
            : model.userModel.data.userData[0].about.content,
        style: TextStyles.body,
      ),
    );
  }

  Widget _buildSkillsAndEducation(BuildContext context, UserProvider model) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          flex: 1,
          child: _buildEducation(model),
        ),
        SizedBox(width: 40.0),
        Expanded(
          flex: 1,
          child: _buildSkills(context, model),
        ),
      ],
    );
  }

  // Skills Methods:------------------------------------------------------------
  final skills = ['N/A'];

  Widget _buildSkills(BuildContext context, UserProvider model) {
    final List<Widget> widgets = model.userModel == null
        ? null
        : model.userModel.data.userData[0].about.skills
            .split(',')
            .map((skill) => Padding(
                  padding: EdgeInsets.only(right: 8.0),
                  child: _buildSkillChip(context, skill),
                ))
            .toList();

    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _buildSkillsContainerHeading(),
        Wrap(children: widgets),
//        _buildNavigationArrows(),
      ],
    );
  }

  Widget _buildSkillsContainerHeading() {
    return Text(
      skills_i_have,
      style: TextStyles.sub_heading,
    );
  }

  Widget _buildSkillChip(BuildContext context, String label) {
    return Chip(
      label: Text(
        label,
        style: TextStyles.chip.copyWith(
          fontSize: ResponsiveWidget.isSmallScreen(context) ? 10.0 : 11.0,
        ),
      ),
    );
  }

  // Education Methods:---------------------------------------------------------
  final educationList = [];

  Widget _buildEducation(UserProvider model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _buildEducationContainerHeading(),
        _buildEducationSummary(),
        SizedBox(height: 8.0),
        _buildEducationTimeline(model),
      ],
    );
  }

  Widget _buildEducationContainerHeading() {
    return Text(
      experience,
      style: TextStyles.sub_heading,
    );
  }

  Widget _buildEducationSummary() {
    return Text(
      'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
      style: TextStyles.body,
    );
  }

  Widget _buildEducationTimeline(UserProvider model) {
    // ignore: omit_local_variable_types
    final List<Widget> widgets = model.userModel == null
        ? null
        : model.userModel.data.userData[0].workExperience
            .map((education) => _buildEducationTile(education))
            .toList();
    return Column(children: widgets);
  }

  Widget _buildEducationTile(WorkExperience education) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            '${education.role}',
            style: TextStyles.company,
          ),
          Text(
            '${education.companyName}',
            style: TextStyles.body.copyWith(
              color: Color(0xFF45405B),
            ),
          ),
          Text(
            '${education.startDate.month.toString() + " / " + education.startDate.day.toString() + " / " + education.startDate.year.toString()} - ${education.endDate.difference(DateTime.now()).inDays > 0 ? 'Presently' : education.endDate.month.toString() + " / " + education.endDate.day.toString() + " / " + education.endDate.year.toString()}',
            style: TextStyles.body,
          ),
          Text(
            '${education.workDescription}',
            style: TextStyles.body,
          ),
        ],
      ),
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
