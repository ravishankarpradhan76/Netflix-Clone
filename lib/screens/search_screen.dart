import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:netfllix_clone/common/utils.dart';
import 'package:netfllix_clone/models/movie_recommendation_mode.dart';
import 'package:netfllix_clone/models/search_model.dart';
import 'package:netfllix_clone/screens/movie_detail_screen.dart';
import 'package:netfllix_clone/services/api_services.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController = TextEditingController();
  ApiServices apiServices = ApiServices();
  late Future<MovieRecommendationsModel> popularMovies;

  SearchModel? searchModel;

  void search(String quary) {
    apiServices.getSearchedMovie(quary).then((results) {
      setState(() {
        searchModel = results;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    popularMovies = apiServices.getPopularMovies();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: CupertinoSearchTextField(
                  padding: EdgeInsets.all(10),
                  controller: searchController,
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.grey,
                  ),
                  suffixIcon: Icon(
                    Icons.cancel,
                    color: Colors.grey,
                  ),
                  style: TextStyle(color: Colors.white),
                  backgroundColor: Colors.grey.withOpacity(0.3),
                  onChanged: (value) {
                    if (value.isEmpty) {
                    } else {
                      search(searchController.text);
                    }
                  },
                ),
              ),
              searchController.text.isEmpty?
              FutureBuilder(
                  future: popularMovies,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      var data = snapshot.data?.results;
                      return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 30,
                            ),
                            Text(
                              "Top Searches",
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics( ),
                              scrollDirection: Axis.vertical,
                              itemCount: data!.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => MovieDetailScreen(
                                              movieId: data[index].id,
                                            ),
                                          ),
                                        );
                                      },
                                      child: InkWell(
                                        onTap: (){
                                          Navigator.push(context, MaterialPageRoute(builder: (context)=> MovieDetailScreen(
                                            movieId: data[index].id,
                                          )));
                                        },
                                        child: Container(
                                          height: 150,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(20)),
                                          child: Row(
                                            children:[ Image.network(
                                              '$imageUrl${data[index].posterPath}',
                                              fit: BoxFit.fitHeight,
                                            ),
                                              SizedBox(width: 20,),
                                              SizedBox(
                                                width: 260,
                                                child: Text(data[index].title,maxLines: 2,
                                                overflow: TextOverflow.ellipsis,),
                                              )
                                          ]
                                          ),
                                        ),
                                      ),
                                    ));
                              },
                            )
                          ]);
                    } else {
                      return const SizedBox.shrink();
                    }
                  }):
              searchModel == null
                  ? SizedBox.shrink()
                  : GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: searchModel!.results.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisSpacing: 8,
                          crossAxisSpacing: 5,
                          childAspectRatio: 1.2 / 2),
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(
                                builder: (context)=> MovieDetailScreen(
                              movieId:
                              searchModel!.results[index].id
                            )));
                          },
                          child: Column(
                            children: [
                              searchModel!.results[index].backdropPath == null
                              ? Image.asset('assets/netflix.png',
                              height: 170,):
                              CachedNetworkImage(
                                imageUrl:
                                    "$imageUrl${searchModel!.results[index].backdropPath}",
                                height: 170,
                              ),
                              SizedBox(
                                width: 100,
                                child: Text(searchModel!.results[index].originalTitle,
                                maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(fontSize: 14),
                                ),
                              )
                            ],
                          ),
                        );
                      })
            ],
          ),
        ),
      ),
    );
  }
}
