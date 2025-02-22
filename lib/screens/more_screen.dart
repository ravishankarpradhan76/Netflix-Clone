import 'package:flutter/material.dart';
import 'package:netfllix_clone/widgets/coming_sonn_widget_card.dart';

class MoreScreen extends StatefulWidget {
  const MoreScreen({super.key});

  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.black,
            title: Text(
              'New & Hot',
              style: TextStyle(color: Colors.white),
            ),
            actions: [
              Icon(Icons.cast, color: Colors.white),
              SizedBox(
                width: 20,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: InkWell(
                  onTap: () {},
                  child: Container(
                    color: Colors.blue,
                    height: 27,
                    width: 27,
                  ),
                ),
              ),
              SizedBox(
                width: 20,
              ),
            ],
            bottom: TabBar(
              dividerColor: Colors.black,
                isScrollable: false,
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.white,
                ),
                labelPadding: EdgeInsets.symmetric(horizontal: 12,vertical:2),
                labelColor: Colors.black,
                labelStyle: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),
                unselectedLabelColor: Colors.white ,
                tabs:[
              Center(child: Tab(text: " Coming Soon",)),
              Center(child: Tab(text: "Everyone's Watching",))
            ]),
          ),
          body: TabBarView(children:[
          SingleChildScrollView(
            child: Column(
              children: [
            ComingSonnWidgetCard(
            imageUrl:
              'https://miro.medium.com/v2/resize:fit:1024/1*P_YU8dGinbCy6GHlgq5OQA.jpeg',
              overview:
              'When a young boy vanishes, a small town uncovers a mystery involving secret experiments, terrifying supernatural forces, and one strange little girl.',
              logoUrl:
              "https://logowik.com/content/uploads/images/stranger-things4286.jpg",
              month: "Jun",
              day: "19",
            ),
            SizedBox(
              height: 20,
            ),
                ComingSonnWidgetCard(
                  imageUrl:
                  'https://www.pinkvilla.com/images/2022-09/rrr-review.jpg',
                  overview:
                  'A fearless revolutionary and an officer in the British force, who once shared a deep bond, decide to join forces and chart out an inspirational path of freedom against the despotic rulers.',
                  logoUrl:
                  "https://www.careerguide.com/career/wp-content/uploads/2023/10/RRR_full_form-1024x576.jpg",
                  month: "Mar",
                  day: "07",
                ),
              ],
            ),
          ),
            ComingSonnWidgetCard(
              imageUrl:
              'https://miro.medium.com/v2/resize:fit:1024/1*P_YU8dGinbCy6GHlgq5OQA.jpeg',
              overview:
              'When a young boy vanishes, a small town uncovers a mystery involving secret experiments, terrifying supernatural forces, and one strange little girl.',
              logoUrl:
              "https://logowik.com/content/uploads/images/stranger-things4286.jpg",
              month: "Feb",
              day: "20",
            ),
          ]),
        ));
  }
}
