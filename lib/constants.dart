import 'package:flutter/cupertino.dart';

const Color mainColor = Color(0xff251844);
const Color secondColor = Color(0xffA026FE);
const Color disabledButtonColor = Color(0xff4E256F);
const Color pinkColor = Color(0xffFF676B);
const Color blueColor = Color(0xff456FFF);
const Color greyColor = Color(0xff9C95AD);
const Color emptyColor = Color(0xff120A27);
const Color redColor = Color.fromRGBO(255, 103, 107, 1);
const Color greenColor = Color(0xff2FDA9C);
const Color orangeColor = Color(0xffFD9B00);

const String femaleSvg = 'assets/images/female.svg';
const String maleSvg = 'assets/images/male.svg';
const String runningIconSvg = 'assets/images/running_icon.svg';
const String barbellIconSvg = 'assets/images/barbell_icon.svg';
const String bodyWeightIconSvg = 'assets/images/bodyweight_icon.svg';
const String starIcon = 'assets/images/star.svg';
const String runningMapIcon = 'assets/images/running_map.svg';
const String teamIcon = 'assets/images/team.svg';
const String heartIcon = 'assets/images/heart.svg';
const String dashboardIcon = 'assets/images/dashboard.svg';
const String selectedTab = 'assets/images/selected_tab.svg';
const String avatar = 'assets/images/avatar.svg';
const String idk = 'assets/images/idkWhatItIs.svg';
const String twitter = 'assets/images/twitter.svg';
const String discord = 'assets/images/discord.svg';
const String messageCircle = 'assets/images/message-circle.svg';
const String groupTell = 'assets/images/group_tell.svg';
const String edit = 'assets/images/edit.svg';
const String xMenAvatar = 'assets/images/x-men.jpg';
const String logo = 'assets/images/logo.jpg';
const String runGroup = 'assets/images/run_group.jpg';

const snackBarDuration = Duration(milliseconds: 300);

const List goals = [
  'Eat better',
  'Improve mental strength',
  'Build muscle',
  'Burn fat',
  'Relieve stress'
];
const Map splits = {
  runningIconSvg: 'Running',
  barbellIconSvg: 'Barbell',
  bodyWeightIconSvg: 'Bodyweight'
};

const cupertinoPickerStyle = CupertinoThemeData(
  textTheme: CupertinoTextThemeData(
    dateTimePickerTextStyle: TextStyle(
      fontSize: 20,
      color: Color(0xff9C95AD),
      fontWeight: FontWeight.w500,
    ),
  ),
);

String hoursStr(int seconds) {
  return ((seconds / 3600) % 60).floor().toString().padLeft(2, '0');
}

String minutesStr(int seconds) {
  return ((seconds / 60) % 60).floor().toString().padLeft(2, '0');
}

String secondsStr(int seconds) {
  return (seconds % 60).floor().toString().padLeft(2, '0');
}

String timeAgo(DateTime d) {
  Duration diff = DateTime.now().difference(d);
  if (diff.inDays > 365) {
    return "${(diff.inDays / 365).floor()} ${(diff.inDays / 365).floor() == 1 ? "year" : "years"} ago";
  }
  if (diff.inDays > 30) {
    return "${(diff.inDays / 30).floor()} ${(diff.inDays / 30).floor() == 1 ? "month" : "months"} ago";
  }
  if (diff.inDays > 7) {
    return "${(diff.inDays / 7).floor()} ${(diff.inDays / 7).floor() == 1 ? "week" : "weeks"} ago";
  }
  if (diff.inDays > 0) {
    return "${diff.inDays} ${diff.inDays == 1 ? "day" : "days"} ago";
  }
  if (diff.inHours > 0) {
    return "${diff.inHours} ${diff.inHours == 1 ? "hour" : "hours"} ago";
  }
  if (diff.inMinutes > 0) {
    return "${diff.inMinutes} ${diff.inMinutes == 1 ? "minute" : "min"} ago";
  }
  return "just now";
}

List leaderboardFilter = ['Today', 'This week', 'All time'];
