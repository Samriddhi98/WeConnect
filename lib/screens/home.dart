import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:weconnect/screens/activity_feed.dart';
import 'package:weconnect/screens/profile.dart';
import 'package:weconnect/screens/search.dart';
import 'package:weconnect/screens/timeline.dart';
import 'package:weconnect/screens/upload.dart';

final GoogleSignIn googleSignIn = GoogleSignIn();

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isAuth = false;
  PageController pageController;
  int pageIndex = 0;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
    // detects when user is signed in
    googleSignIn.onCurrentUserChanged.listen((account) {
      handleSignIn(account);
    }, onError: (err) {
      print('Error signing in: $err');
    });
    // reauthenticate user when app is opened
    googleSignIn.signInSilently(suppressErrors: false).then((account) {
      handleSignIn(account);
    }).catchError((err) {
      print('Error signing in: $err');
    });
  }

  handleSignIn(GoogleSignInAccount account) {
    if (account != null) {
      print('User signed in!: $account');
      setState(() {
        isAuth = true;
      });
    } else {
      setState(() {
        isAuth = false;
      });
    }
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  login() {
    googleSignIn.signIn();
  }

  logout() {
    googleSignIn.signOut();
  }

  onPageChanged(int pageIndex) {
    setState(() {
      this.pageIndex = pageIndex;
    });
  }

  onTap(int pageIndex) {
    pageController.animateToPage(pageIndex,
        duration: Duration(microseconds: 500), curve: Curves.easeInOut);
  }

  Scaffold buildAuthScreen() {
    return Scaffold(
        body: PageView(
          children: [
            Timeline(),
            ActivityFeed(),
            Upload(),
            Search(),
            Profile(),
          ],
          controller: pageController,
          //function takes index
          onPageChanged: onPageChanged,
          physics: NeverScrollableScrollPhysics(),
        ),
        bottomNavigationBar: new Theme(
          data: Theme.of(context).copyWith(
              // sets the background color of the `BottomNavigationBar`
              //  canvasColor: Theme.of(context).accentColor,
              // sets the active color of the `BottomNavigationBar` if `Brightness` is light
              primaryColor: Theme.of(context).primaryColor,
              textTheme: Theme.of(context)
                  .textTheme
                  .copyWith(caption: new TextStyle(color: Colors.yellow))),
          child: BottomNavigationBar(
            currentIndex: pageIndex,
            onTap: onTap,
            unselectedItemColor: Colors.grey,
            selectedItemColor: Theme.of(context).primaryColor,
            items: [
              BottomNavigationBarItem(
                label: '',
                icon: Icon(Icons.whatshot),
              ),
              BottomNavigationBarItem(
                label: '',
                icon: Icon(Icons.notifications_active),
              ),
              BottomNavigationBarItem(
                label: '',
                icon: Icon(
                  Icons.photo_camera,
                  size: 35.0,
                ),
              ),
              BottomNavigationBarItem(
                label: '',
                icon: Icon(Icons.search),
              ),
              BottomNavigationBarItem(
                label: '',
                icon: Icon(Icons.account_circle),
              ),
            ],
          ),
        ));
    // return RaisedButton(
    //   onPressed: logout,
    //   child: Text('Logout'),
    // );
  }

  Widget buildUnAuthScreen() {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
              Theme.of(context).accentColor,
              Theme.of(context).primaryColor
            ])),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'We Connect',
              style: TextStyle(
                fontFamily: 'Signatra',
                fontSize: 80.0,
                color: Colors.white,
              ),
            ),
            GestureDetector(
              onTap: () => login(),
              child: Container(
                width: 260.0,
                height: 60.0,
                decoration: BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage('assets/images/google_signin_button.png'),
                  fit: BoxFit.cover,
                )),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return isAuth ? buildAuthScreen() : buildUnAuthScreen();
  }
}
