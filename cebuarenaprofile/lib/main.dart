// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';

void main() {
  runApp(ProfileApp());
}

class ProfileApp extends StatefulWidget {
  @override
  State<ProfileApp> createState() => _ProfileAppState();
}

class _ProfileAppState extends State<ProfileApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Profile App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ProfileScreen(),
    );
  }
}

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> with SingleTickerProviderStateMixin {
  late double coverHeight;
  late double profileHeight;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    coverHeight = MediaQuery.of(context).size.height * 0.3; // 30% of the screen height
    profileHeight = coverHeight * 0.5; // half of the cover height
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.4, // Adjust this value as needed
            child: buildProfileBody(context),
          ),
          Expanded(
            child: buildTab(),
          ),
        ],
      ),
    );
  }

 Widget buildProfileBody(BuildContext context) {
  return LayoutBuilder(
    builder: (context, constraints) {
      final coverHeight = constraints.maxHeight * 0.6;
      final profileHeight = coverHeight * 0.5;
      final profileWidth = constraints.maxWidth * 0.3;

      return Stack(
        children: [
          FractionallySizedBox(
            widthFactor: 1,
            heightFactor: 0.6,
            child: buildCoverPhoto(),
          ),
          Positioned(
            left: profileWidth * 0.1, // 10% of the profile width
            bottom: coverHeight * 0.35, // 20% of the cover height
            child: buildProfilePhoto(),
          ),
          Positioned(
            left: profileWidth * 0.1, // 10% of the profile width
            bottom: coverHeight * 0.1, // 10% of the cover height
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildTextWithPadding('Master Leeroy', 20, FontWeight.bold),
                buildTextWithPadding('@sojugaming', 14, FontWeight.normal),
              ],
            ),
          ),
          Positioned(
            left: profileWidth * 1.2, // same as profile width
            bottom: coverHeight * 0.4, // 30% of the cover height
            child: Row(
              children: [
                Column(
                  children: [
                    buildTagWithIcon(context, 'Player', Icons.verified_user),
                    SizedBox(height: 10),
                    buildTagWithIcon(context, 'Organizer', Icons.verified_user),
                  ],
                ),
                SizedBox(width: 40),
                ElevatedButton(
                  onPressed: () {},
                  child: Text('View Org'),
                ),
              ],
            ),
          ),
        ],
      );
    },
  );
}

  Widget buildCoverPhoto() {
    return Container(
      width: double.infinity,
      height: coverHeight,
      decoration: BoxDecoration(
        color: Colors.blue,
        image: DecorationImage(
          image: AssetImage('images/Cover_White.jpg'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget buildProfilePhoto() {
    return CircleAvatar(
      radius: profileHeight/2,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white, width: 3),
          image: DecorationImage(
            image: AssetImage('images/Profile.png'),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
  
  Widget buildTab() {
  return Column(
    children: [
      Container(
        color: Colors.blue, // define the background color for tabs
        child: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.grey,
          labelStyle: TextStyle(fontFamily: 'Montserrat', fontSize: 16), // define the font style here
          tabs: [
            Tab(text: 'About'),
            Tab(text: 'Teams'),
            Tab(text: 'Album'),
          ],
        ),
      ),
      Expanded(
        child: Container(
          child: TabBarView(
            controller: _tabController,
            children: [
              buildAboutSection(),
              buildTeamsSection(),
              buildAlbumSection(),
            ],
          ),
        ),
      ),
    ],
  );
}


  Widget buildAboutSection() {
    return Center(
      child: Text('About Section'),
    );
  }

  Widget buildTeamsSection() {
    return Center(
      child: Text('Teams Section'),
    );
  }

  Widget buildAlbumSection() {
    return Center(
      child: Text('Album Section'),
    );
  }

  Widget buildTagWithIcon(BuildContext context, String tag, IconData icon) {
    return Row(
      children: [
        Icon(
          icon,
          color: Colors.blue,
          size: 16,
        ),
        SizedBox(width: 5),
        Text(
          tag,
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  Widget buildTextWithPadding(String text, double fontSize, FontWeight fontWeight) {
    return Padding(
      padding: EdgeInsets.only(left: 10),
      child: Text(
        text,
        style: TextStyle(
          fontFamily: 'Montserrat',
          fontSize: fontSize,
          fontWeight: fontWeight,
        ),
      ),
    );
  }
}
