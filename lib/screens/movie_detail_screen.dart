import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:netfllix_clone/common/utils.dart';
import 'package:netfllix_clone/models/movie_detail_model.dart';
import 'package:netfllix_clone/services/api_services.dart';
import 'package:netfllix_clone/models/movie_recommendation_mode.dart';

class MovieDetailScreen extends StatefulWidget {
  final int movieId;
  const MovieDetailScreen({super.key, required this.movieId});

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  ApiServices apiServices = ApiServices();

  late Future<MovieDetailModel> movieDetail;
  late Future<MovieRecommendationsModel> movieRecommendations;

  @override
  void initState() {
    fetchInitialData();
    super.initState();
  }

  fetchInitialData() {
    movieDetail = apiServices.getMoviesDetail(widget.movieId);
    movieRecommendations = apiServices.getMovieRecommendations();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
          child: FutureBuilder(
              future: movieDetail,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  print(snapshot.data?.posterPath);
                  String genreText = snapshot.data!.genres
                      .map((genre) => genre.name)
                      .join(", ");
                  return Column(
                    children: [
                      Stack(
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height / 2.2,
                            width: MediaQuery.of(context).size.width / 1,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(
                                        "${imageUrl ?? ""}${snapshot.data?.posterPath}" ??
                                            ""),
                                    fit: BoxFit.fill)),
                          ),
                          Positioned(
                            top: 35,
                            left: 10,
                            child: IconButton(
                              icon: Icon(
                                Icons.arrow_back_ios,
                                color: Colors.red,
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 22,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            snapshot.data?.title ?? "",
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: [
                              Text(snapshot.data!.releaseDate.year.toString()),
                              SizedBox(
                                width: 30,
                              ),
                              Text(
                                genreText,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 17),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            snapshot.data!.overview,
                            maxLines: 6,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      FutureBuilder(
                          future: movieRecommendations,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              final movie = snapshot.hasData;

                              return snapshot.data!.results.isEmpty
                                  ? SizedBox()
                                  : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('More Like This'),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        GridView.builder(
                                            itemCount:
                                                snapshot.data!.results.length,
                                            shrinkWrap: true,
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            gridDelegate:
                                                SliverGridDelegateWithFixedCrossAxisCount(
                                                    crossAxisCount: 3,
                                                    mainAxisSpacing: 15,
                                                    crossAxisSpacing: 5,
                                                    childAspectRatio: 1.5 / 2),
                                            itemBuilder: (context, index) {
                                              return InkWell(
                                                onTap: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              MovieDetailScreen(
                                                                  movieId: snapshot
                                                                      .data!
                                                                      .results[
                                                                          index]
                                                                      .id)));
                                                },
                                                child: CachedNetworkImage(
                                                  imageUrl:
                                                      "$imageUrl${snapshot.data!.results[index].posterPath}",
                                                ),
                                              );
                                            })
                                      ],
                                    );
                            } else {
                              return Text('Something Went wrong');
                            }
                          })
                    ],
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(
                      color: Colors.red,
                    ),
                  );
                }
              }),
        ));
  }
}
