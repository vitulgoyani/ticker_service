import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ticker_service/controller/get_user_list_controller.dart';

class UserListPage extends StatefulWidget {
  const UserListPage({Key? key}) : super(key: key);

  @override
  _UserListPageState createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  ScrollController _scrollController = new ScrollController();
  final GetUserListController getUserListController =
      Get.put(GetUserListController());
  TextEditingController searchController = new TextEditingController();
  String? filter;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.atEdge) {
        if (_scrollController.position.pixels == 0) {
          // You're at the top.
        } else {
          getUserListController
              .getUserListAPICall(getUserListController.listOfUser.last.id);
        }
      }
    });

    searchController.addListener(() {
      if (this.mounted)
        setState(() {
          filter = searchController.text;
        });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ticker List"),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: TextField(
                  autocorrect: false,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    suffixIcon: searchController.text != ""
                        ? IconButton(
                            icon: Icon(Icons.close),
                            onPressed: () {
                              searchController.clear();
                              FocusScope.of(context).requestFocus(FocusNode());
                            },
                          )
                        : SizedBox(),
                    hintText: "Search company name",
                  ),
                  controller: searchController,
                ),
              ),
              Divider(),
              Expanded(
                child: Obx(() {
                  if (getUserListController.isLoading.value) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return ListView.builder(
                        shrinkWrap: true,
                        controller: _scrollController,
                        itemCount: getUserListController.listOfUser.length,
                        itemBuilder: (context, index) {
                          if (filter == null || filter == "") {
                            return Card(
                                child: Column(
                              children: [
                                ListTile(
                                  leading: Container(
                                    height:40,
                                    width: 40,
                                    child: CachedNetworkImage(
                                      imageUrl: getUserListController
                                              .listOfUser[index].logoUrl ??
                                          "",
                                      imageBuilder: (context, imageProvider) =>
                                          CircleAvatar(
                                              backgroundColor: Colors.white,
                                              backgroundImage: imageProvider),
                                      placeholder: (context, url) => Center(
                                          child: CupertinoActivityIndicator()),
                                      errorWidget: (context, url, error) =>
                                          Icon(Icons.account_circle_rounded,size: 40),
                                    ),
                                  ),
                                  /* CircleAvatar(
                                      backgroundImage: NetworkImage(
                                          getUserListController
                                                  .listOfUser[index].logoUrl ??
                                              "")),*/
                                  title: Text(
                                      "${getUserListController.listOfUser[index].name} "),
                                )
                              ],
                            ));
                          } else {
                            String name =
                                getUserListController.listOfUser[index].name ??
                                    "";
                            if (name
                                .toLowerCase()
                                .contains(filter!.toLowerCase())) {
                              return ListTile(
                                leading: CircleAvatar(
                                    backgroundImage: NetworkImage(
                                        getUserListController
                                                .listOfUser[index].name ??
                                            "")),
                                title: Text(
                                    "${getUserListController.listOfUser[index].name} "),
                              );
                            } else {
                              return const SizedBox();
                            }
                          }
                        });
                  }
                }),
              ),
            ],
          ),
          Obx(() {
            return getUserListController.isLoadingMore == true
                ? Positioned.fill(
                    child: Container(
                        color: Colors.black54,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircularProgressIndicator(),
                              SizedBox(height: 10),
                              Text(
                                "Load more data...",
                                style: TextStyle(color: Colors.white),
                              )
                            ],
                          ),
                        )))
                : SizedBox();
          }),
        ],
      ),
    );
  }
}
