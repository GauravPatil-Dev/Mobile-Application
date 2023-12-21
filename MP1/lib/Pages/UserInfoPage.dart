
import 'package:cs442_mp1/Model/UserInfo.dart';
import 'package:flutter/material.dart';

class UserInfoPage extends StatelessWidget {
  const UserInfoPage({super.key});
  static List<UserInfo> userinfo = [];
  void _getInitialInfo() {
    userinfo = UserInfo.getUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    _getInitialInfo();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
      ),
      backgroundColor: const Color.fromARGB(255, 108, 143, 173),
      body: const MyListView(),
    );
  }
}

class MyListView extends StatelessWidget {
  const MyListView({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return 
    ListView(
      children: [
          Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              alignment: Alignment.topLeft,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Image.asset(
                  'assets/images/profile.jpeg',
                  width: screenWidth * 0.15, // Responsive image width
                  height: screenWidth * 0.15, // Responsive image height
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildBorderSizedBox(UserInfoPage.userinfo, 'name', screenWidth),
                _buildBorderSizedBox(UserInfoPage.userinfo, 'position', screenWidth),
                _buildBorderSizedBox(UserInfoPage.userinfo, 'company', screenWidth),
              ],
            )
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _createRow('assets/images/icon-call.png', UserInfoPage.userinfo.first.phone, screenWidth),
            _createRow('assets/images/icon-email.png', UserInfoPage.userinfo.first.email, screenWidth),
            _createRow('assets/images/icon-home.png', UserInfoPage.userinfo.first.address1 + UserInfoPage.userinfo.first.address2, screenWidth),
          ],
        ),
        Container(
          child: _educationListView(screenWidth),
        ),
        const MyGridView(),
      ],
    );
  }

  Widget _createRow(String image, String text, double screenWidth) {
    return 
    Align(
  alignment: Alignment.centerLeft,
  child: Container(
      //color: Colors.black,
      width: screenWidth*0.6,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Image.asset(
          image,
          width: 40.0,
          height: 40.0,
        ),
        Text(
          text,
          style: TextStyle(fontSize: screenWidth*0.015),
        ),
      ],
    ),
    )
    );
  }

  Widget _buildBorderSizedBox(List<UserInfo> userinfo, String key, double screenWidth) {
    return SizedBox(
      width: screenWidth * 0.6, // Responsive box width
      height: 60,
      child: Container(
        margin: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black,
            width: 1.0,
          ),
          color: const Color.fromARGB(255, 126, 131, 135),
        ),
        child: Center(
            child: Text(
          key == 'name'
              ? userinfo.first.name
              : key == 'position'
                  ? userinfo.first.position
                  : key == 'company'
                      ? userinfo.first.company
                      : 'Invalid Key', // Handle unsupported keys
          style: const TextStyle(color: Colors.white),
        )),
      ),
    );
  }

  Widget _educationListView(double screenWidth) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 30,
        ),
        const Text(
          'Education',
          style: TextStyle(color: Colors.black, fontSize: 24.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 50, // Adjust the height as needed
          child: _buildRow(
            "University Name",
            "GPA",
            "Year",
            screenWidth,
            false
            ),
        ),
        SizedBox(
          height: 50, // Adjust the height as needed
          child: _buildRow(
            UserInfoPage.userinfo.first.education[0]['name'],
            UserInfoPage.userinfo.first.education[0]['gpa'],
            UserInfoPage.userinfo.first.education[0]['year'],
            screenWidth,
            true
            ),
        ),
        SizedBox(
          height: 50, // Adjust the height as needed
          child: _buildRow(
            UserInfoPage.userinfo.first.education[1]['name'],
            UserInfoPage.userinfo.first.education[1]['gpa'],
            UserInfoPage.userinfo.first.education[1]['year'],
            screenWidth,
            true
          ),
        ),
      ],
    );
  }

  Widget _buildRow(String schoolName, String gpa, String year, double screenWidth, bool shouldDecorate) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildBorderContainer(schoolName, screenWidth, shouldDecorate),
        _buildBorderContainer(gpa, screenWidth, shouldDecorate),
        _buildBorderContainer(year, screenWidth, shouldDecorate),
      ],
    );
  }

  Widget _buildBorderContainer(String text, double screenWidth, bool shouldDecorate) {
    return Container(
      width: screenWidth * 0.2,
      padding: const EdgeInsets.all(8.0),
          decoration: shouldDecorate
          ? BoxDecoration(
              // Apply decoration when shouldDecorate is true
              border: Border.all(
                color: Colors.black,
                width: 1.0,
              ),
              //borderRadius: BorderRadius.circular(8.0),
            )
          : null,
      
      child: FittedBox(
      fit: BoxFit.scaleDown, // Scales down the text to fit
      child: Text(
        text,
        style: TextStyle(fontSize: screenWidth * 0.02),
      ),
    ),
    );
  }
}

class MyGridView extends StatelessWidget {
  const MyGridView({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      width: screenWidth*0.6,
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Projects', // Title
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4, // Number of columns
              mainAxisSpacing: 10.0, // Vertical spacing
              crossAxisSpacing: 10.0, // Horizontal spacing
            ),
            shrinkWrap: true,
            itemCount: 4,
            itemBuilder: (BuildContext context, int index) {
              return GridItem(
                text: UserInfoPage.userinfo.first.projects[index].projectName,
                text1: UserInfoPage.userinfo.first.projects[index].projectDescription,
                color: Color.fromARGB(255, 139, 162, 149),
              );
            },
          ),
        ],
      ),
    );
  }
}

  class GridItem extends StatelessWidget {
  final String text;
  final String text1;
  final Color color;
  const GridItem({super.key,required this.text, required this.text1, this.color = Colors.white});

   @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double fontSize = screenWidth * 0.01;
    return Container(
      width: screenWidth*0.6,
      decoration: const BoxDecoration(
        shape: BoxShape.circle, // Make the container circular
        //color: color, // Set the background color here
      ),
      padding: const EdgeInsets.all(8.0),
        child: Column(
        children: [
          Text(text, style: TextStyle(fontSize: fontSize, fontWeight:FontWeight.bold )),
          Align(
          alignment: Alignment.center, // Align however you like (i.e .centerRight, centerLeft)
          child: Text(text1, style: TextStyle(fontSize: fontSize, fontStyle: FontStyle.normal),),
          ),
          
        ],
      ),
  );
  }
}
