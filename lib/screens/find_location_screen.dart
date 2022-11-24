import 'package:flutter/material.dart';
import 'package:metch/domain/services/club_service.dart';
import 'package:metch_ui_kit/metch_ui_kit.dart';

class FindLocationScreen extends StatefulWidget {
  const FindLocationScreen({Key? key}) : super(key: key);

  @override
  State<FindLocationScreen> createState() => _FindLocationScreenState();
}

class _FindLocationScreenState extends State<FindLocationScreen> {
  late ClubService clubService;
  TextEditingController clubInputController = TextEditingController();

  @override
  void initState() {
    super.initState();
    clubService = ClubService();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const BackButton(),
          TextField(
            controller: clubInputController,
            onChanged: (value) => clubService.searchClubs(value),
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'The Padel Club Amsterdam...',
            ),
          ),
        ],
      ),
    );
  }
}
