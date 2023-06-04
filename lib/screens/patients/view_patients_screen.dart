import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../services/fetch_patients_service.dart';
import '../../shared/background_wave_container.dart';
import '../../navigators/view_patients_list_navigator.dart';
import 'patient_screen.dart';

class ViewPatientsListScreen extends StatefulWidget {
  List allPatients = [];

  ViewPatientsListScreen(this.allPatients, {Key? key}) : super(key: key);

  @override
  State<ViewPatientsListScreen> createState() =>
      _ViewPatientsListScreenScreenState();
}

class _ViewPatientsListScreenScreenState extends State<ViewPatientsListScreen> {
  List viewPatientsList = [];
  bool isLoading = false;
  // late ValueNotifier<List> _myString;

  @override
  void initState() {
    super.initState();
    // print("fgfg");
    // print(widget.allPatients[0].name);

    // viewPatientsList = widget.allPatients;
    // _myString = ValueNotifier<List>(widget.allPatients);

    // _myString.addListener(() => viewPatientsList = widget.allPatients);
  }

  // loadPatientsList() async {
  //   isLoading = true;
  //   allPatients = await fetchPatients();
  //   viewPatientsList = allPatients;
  //   setState(() {
  //     isLoading = false;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: isLoading
            ? const Center(child: CircularProgressIndicator())
            : CustomScrollView(
                slivers: [
                  SliverPersistentHeader(
                    delegate: SliverSearchAppBar(searchCallBack, resetCallback),
                    // Set this param so that it won't go off the screen when scrolling
                    pinned: true,
                  ),
                  SliverList(
                      delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                    var patient = widget.allPatients[index];
                    return ListTile(
                      shape: Border(
                        bottom: BorderSide(color: Colors.grey, width: 0),
                      ),
                      title: Text(
                        patient.name,
                        style: TextStyle(fontSize: 20),
                      ),
                      leading: Text(patient.age.toString()),
                      subtitle: Text(patient.address),
                      trailing: IconButton(
                          icon: Icon(Icons.arrow_circle_right_outlined),
                          onPressed: () {
                            Get.to(PatientScreen(
                              existingPatient: patient,
                            ));
                          }),
                    );
                  }, childCount: widget.allPatients.length))
                ],
              ));
  }

  searchCallBack(String val) {
    setState(() {
      print(val);
      widget.allPatients = [];
      for (var element in ViewPatientsListNavigator.allPatients) {
        widget.allPatients.add(element);
      }
      widget.allPatients.retainWhere((patient) {
        return patient.name.toLowerCase().contains(val.toLowerCase());
        //you can add another filter conditions too
      });
    });
  }

  resetCallback() {
    print("reset");
    print(widget.allPatients);
    setState(() {
      widget.allPatients = [];
      for (var element in ViewPatientsListNavigator.allPatients) {
        widget.allPatients.add(element);
      }
      print(widget.allPatients);
    });
  }
}

class SliverSearchAppBar extends SliverPersistentHeaderDelegate {
  final Function(String) submitCallback;
  final Function() resetCallback;

  const SliverSearchAppBar(this.submitCallback, this.resetCallback, {Key? key});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    var adjustedShrinkOffset =
        shrinkOffset > minExtent ? minExtent : shrinkOffset;
    double offset = (minExtent - adjustedShrinkOffset) * 0.1;
    double topPadding = MediaQuery.of(context).padding.top;

    return Stack(
      children: [
        SizedBox(
          height: 280,
          child: ClipPath(
              clipper: BackgroundWaveClipper(),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 280,
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                  colors: [Colors.teal, Color.fromARGB(255, 91, 224, 193)],
                )),
              )),
        ),
        Positioned(
          top: topPadding + offset,
          left: 16,
          right: 16,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: const Icon(Icons.arrow_back)),
                  const Text('My Patients',
                      style: TextStyle(
                          fontSize: 30,
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontFamily: "Signika")),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  AnimSearchBar(
                    helpText: 'Search by name',
                    onSubmitted: (val) {
                      submitCallback(val);
                    },
                    textController: TextEditingController(),
                    onSuffixTap: resetCallback,
                    suffixIcon: Icon(Icons.refresh),
                    // closeSearchOnSuffixTap: true,
                    // autoFocus: true,
                    width: MediaQuery.of(context).size.width - 32,
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }

  @override
  double get maxExtent => 280;

  @override
  double get minExtent => 190;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      oldDelegate.maxExtent != maxExtent || oldDelegate.minExtent != minExtent;
}
