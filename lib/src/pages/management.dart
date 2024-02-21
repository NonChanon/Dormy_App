import 'package:dorm_app/src/pages/announcement.dart';
import 'package:dorm_app/src/pages/new_report.dart';
import 'package:dorm_app/src/pages/report.dart';
import 'package:flutter/material.dart';

class Management extends StatefulWidget {
  const Management({Key? key});

  @override
  State<Management> createState() => _ManagementState();
}

class _ManagementState extends State<Management> {
  TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 245,
          child: PageView.builder(
            itemCount: 1,
            itemBuilder: (context, position) {
              return _buildPageItem(position);
            },
          ),
        ),
        Container(
          decoration: BoxDecoration(
            border:
                Border(bottom: BorderSide(width: 1, color: Color(0xFFD9D9D9))),
          ),
          padding: EdgeInsets.only(bottom: 20),
          margin: EdgeInsets.only(left: 35, right: 35, bottom: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _filterMenu("Availabitity"),
              SizedBox(width: 10),
              _filterMenu("Rented"),
              SizedBox(width: 10),
              _filterMenu("Unpaid"),
              SizedBox(width: 10),
              _filterMenu("Paid"),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 20, right: 20),
          child: Row(
            children: [
              Text(
                "Room",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Container(
          child: _buildMenu(Icons.newspaper, "Announce", AnnouncementPage()),
        )
      ],
    );
  }

  Widget _buildPageItem(int index) {
    return Stack(
      children: [
        Container(
          height: 200,
          color: Colors.black,
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Container(
            height: 60,
            margin: EdgeInsets.only(left: 40, right: 40, top: 25),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Color(0xFFFDCD34),
            ),
            alignment: Alignment.center,
            child: Container(
              padding: EdgeInsets.only(top: 5, bottom: 5, left: 20, right: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(right: 10),
                      margin: EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                        border: Border(
                            right: BorderSide(width: 1, color: Colors.black)),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.apartment, size: 26),
                          SizedBox(width: 5),
                          Expanded(
                            child: Text(
                              'Happy Apartmentssss',
                              textAlign: TextAlign.center,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: 100,
                    child: Text(
                      'Building Happy',
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: Container(
            height: 40,
            width: 120,
            margin: EdgeInsets.only(left: 40, right: 40, top: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Color(0xFFFDCD34),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Icon(Icons.location_on_outlined, size: 26),
                Text(
                  '1st Floor',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 25,
          left: 40,
          right: 40,
          child: Container(
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 2,
                  offset: Offset(0, 2), // changes position of shadow
                ),
              ],
            ),
            child: Container(
              padding: EdgeInsets.only(
                left: 10,
                right: 10,
              ),
              child: Row(
                children: [
                  Icon(Icons.search),
                  SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: "Search room number...",
                        border: InputBorder.none,
                      ),
                      onChanged: (value) {},
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _filterMenu(String label) {
    return Container(
      child: Row(children: [
        Container(
          decoration: BoxDecoration(
            color: Color(0xFFF5F5F5),
            borderRadius: BorderRadius.circular(5),
          ),
          padding: EdgeInsets.only(top: 5, bottom: 5, left: 15, right: 15),
          child: Text(label),
        ),
      ]),
    );
  }

  Widget _buildMenu(IconData icon, String label, Widget page) {
    return Wrap(
      spacing: 20,
      runSpacing: 20,
      children: List.generate(
        100,
        (index) => SizedBox(
          width: 110,
          child: GestureDetector(
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => page));
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Color(0xFFFDCD34),
              ),
              width: 110,
              height: 110,
              child: Icon(icon, size: 35),
            ),
          ),
        ),
      ),
    );
  }
}
