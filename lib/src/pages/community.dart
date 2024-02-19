import 'package:dorm_app/src/component/community_body.dart';
import 'package:flutter/material.dart';

class Community extends StatelessWidget {
  const Community({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CommunityBody(),
    );
  }
}
