import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:badges/badges.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(vsync: this, length: 3);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xFF333742),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Badge(
              badgeContent: Text('2'),
              badgeColor: Colors.white,
              child: Icon(Icons.notifications_none),
            ),
          )
        ],
        bottom: TabBar(
          controller: tabController,
          indicatorColor: Color(0xFF333742),
          tabs: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text("hi"),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text("hi"),
            ),Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text("hi"),
            ),
          ],
        ),
      ),
      drawer: Drawer(
        backgroundColor: Color(0xFF333742),
        child: Center(
          child: Text(
            "Created by Ibrahim Shaglil",
            style: Theme.of(context)
                .textTheme
                .headline6!
                .copyWith(color: Colors.white),
          ),
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: [
          TabPage(),
          TabPage(),
          TabPage(),
        ],
      ),
    );
  }
}

class TabPage extends StatelessWidget {
  const TabPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        return GridView.builder(
          padding: EdgeInsets.only(top: 8, left: 16, right: 16),
          itemCount: 10,
          itemBuilder: (BuildContext context, int index) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(16.0),
              child: Container(
                height: 100,
                child: Stack(
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          flex: 7,
                          child: Container(
                            color: Color(0xFF48505c),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Container(
                            color: Color(0xFF454d5a),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: Container(
                                  color: Color(0xFF333742),
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Row(
                                      children: [
                                        Text("4.5",style: Theme.of(context).textTheme.bodyText2!.copyWith(color: Colors.white),),
                                        Icon(Icons.star,color: Color(0xFFfdd14b),),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: FaIcon(FontAwesomeIcons.solidHeart,color: Colors.white,),
                            )
                          ],
                        ),
                        Expanded(child: Image.asset("assets/1.png")),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text("Dual Sense",style: Theme.of(context).textTheme.headline5!.copyWith(color: Colors.white)),
                        ),
                        SizedBox(height: 8,),
                        Padding(
                          padding:  const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text("850 S.P",style: Theme.of(context).textTheme.headline6!.copyWith(color: Colors.white)),
                              SizedBox(width: 8,),
                              Text("900 S.P",style: Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.white,decoration: TextDecoration.lineThrough,)),
                            ],
                          ),

                        ),
                        SizedBox(height: 8,),
                      ],
                    ),
                    Positioned(
                      right: 16,
                      bottom: 60,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Container(
                          color: Color(0xFF333742),
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Icon(Icons.add_shopping_cart,color: Colors.white,),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: orientation == Orientation.portrait ? 2 : 4,
              childAspectRatio: 0.7,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16),
        );
      },
    );
  }
}
