import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Playing With Tab Bar',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Playing With Tab Bar'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;


  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {
  int pageNo = 0;
  TabController _tabController;

  void initState() {
    _tabController = new TabController(
      vsync: this,
      length: 3,
    );
  }

  void forwardTabPage() {
    if (pageNo >= 0 && pageNo < 3) {
      setState(() {
        pageNo = pageNo + 1;
      });
      _tabController.animateTo(pageNo);
    }
  }

  void backwardTabPage() {
    if (pageNo >= 1 && pageNo < 3) {
      setState(() {
        pageNo = pageNo - 1;
      });
      _tabController.animateTo(pageNo);
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          bottom: TabBar(
            controller: _tabController,
            onTap: (val){
              setState(() {
                pageNo=val;
              });
            },
            tabs: [
              Tab(
                icon: Icon(Icons.home_outlined),
                child: Text("Home"),
              ),
              Tab(
                //text: "Cultural Service",
                icon: Icon(Icons.restaurant_outlined),
                child: Text("Restaurant"),
              ),
              Tab(
                //text: "Cultural Service",
                icon: Icon(Icons.hotel_outlined),
                child: Text("Hotels"),
              )
            ],
          ),

        ),
        body: Container(

          child: TabBarView(
            controller: _tabController,
              physics: NeverScrollableScrollPhysics(),
            children: [
              Center(
                child: Text("Home Tab View"),
              ),
              Center(
                child: Text("Map Tab View"),
              ),
              Center(
                child: Text("Hotel Tab View"),
              )
            ],
          ),
        ),
        persistentFooterButtons: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 40,
            padding: EdgeInsets.only(bottom: 0.0),
            margin: EdgeInsets.only(bottom: 10.0, top: 0.0),
            child: Center(
              child: ListTile(
                title: Center(
                  child: Text("Page No: ${(pageNo+1).toString()}"),
                ),
                leading: (pageNo!=0)?FloatingActionButton(
                    elevation: 4.0,
                    child: new Icon(Icons.arrow_back_outlined),
                    onPressed: () {
                      backwardTabPage();

                    }):SizedBox(),
                trailing: (pageNo!=2)?FloatingActionButton(
                    elevation: 4.0,
                    child: new Icon(
                      Icons.arrow_forward_outlined,
                    ),
                    onPressed: () {
                      forwardTabPage();
                    }):SizedBox(),
              ),
            ),
          )
        ],
      ),
    );
  }
}
