import 'dart:async';
import 'dart:io';

import 'package:ceylife_digital/features/domain/entities/response/branch_response_entity.dart';
import 'package:ceylife_digital/utils/app_images.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:huawei_map/map.dart';

import 'const/field_decorations.dart';
import 'widgets/location_marker_card.dart';

class HuaweiMapView extends StatefulWidget {
  final List<BranchEntity> branchData;

  HuaweiMapView({this.branchData});

  static final CameraPosition _sriLankaMap = CameraPosition(
    target: LatLng(7.294544, 80.5907616),
    zoom: 8,
  );

  @override
  _HuaweiMapViewState createState() => _HuaweiMapViewState();
}

class _HuaweiMapViewState extends State<HuaweiMapView> {
  final _controller = TextEditingController();
  bool viewList = false;
  bool isCardShowing = false;
  String selectedBranch;
  HuaweiMapController mapController;

  List<BranchEntity> searchedList = [];
  List<Marker> selectedMarkers = [];
  List<Marker> markers = [];
  BitmapDescriptor customIcon;
  BranchEntity _selectedBranch;

  Completer<HuaweiMapController> _mapController = Completer();

  createMarkers() async {
    await HuaweiMapUtils.disableLogger();
    customIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 0.5),
        Platform.isAndroid ? AppImages.marker : AppImages.markeriOS);
  }

  @override
  void initState() {
    createMarkers();
    super.initState();
  }

  void _onMapCreated(HuaweiMapController controller) async {
    mapController = controller;
    _mapController.complete(controller);
    setState(() {
      widget.branchData.forEach((branch) {
        markers.add(Marker(
            draggable: false,
            markerId: MarkerId(branch.title),
            position: LatLng(
                double.parse(branch.latitude), double.parse(branch.longitude)),
            icon: customIcon,
            onClick: () {
              setState(() {
                viewList = false;
                _selectedBranch = branch;
                isCardShowing = true;
              });
            }));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        HuaweiMap(
          mapType: MapType.normal,
          compassEnabled: false,
          zoomControlsEnabled: false,
          zoomGesturesEnabled: true,
          scrollGesturesEnabled: true,
          rotateGesturesEnabled: true,
          initialCameraPosition: HuaweiMapView._sriLankaMap,
          onMapCreated: _onMapCreated,
          onClick: (location) {
            setState(() {
              viewList = false;
            });
          },
          markers: selectedMarkers.isEmpty
              ? Set.from(markers)
              : Set.from(selectedMarkers),
          gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>[
            new Factory<OneSequenceGestureRecognizer>(
              () => new EagerGestureRecognizer(),
            ),
          ].toSet(),
        ),
        Padding(
          padding: const EdgeInsets.all(15),
          child: Container(
            decoration: BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(color: Color(0x1A000000), blurRadius: 10)
            ]),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  viewList == false ? viewList = true : viewList = false;
                });
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Expanded(child: _buildTextField()),
                      Padding(
                        padding: const EdgeInsets.all(11.0),
                        child: SvgPicture.asset(AppImages.search),
                      )
                    ],
                  ),
                  viewList
                      ? SizedBox(
                          height: 230,
                          child: ListView.builder(
                            physics: BouncingScrollPhysics(),
                            itemCount: searchedList.isEmpty
                                ? widget.branchData.length
                                : searchedList.length,
                            itemBuilder: (context, index) {
                              final item = searchedList.isEmpty
                                  ? widget.branchData[index]
                                  : searchedList[index];
                              return Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Center(
                                  child: ListTile(
                                    title: Text(item.title),
                                    subtitle: Text(item.address),
                                    onTap: () async {
                                      final HuaweiMapController controller =
                                          await _mapController.future;
                                      setState(() {
                                        isCardShowing = false;
                                        selectedMarkers.add(Marker(
                                            draggable: false,
                                            markerId: MarkerId(item.title),
                                            position: LatLng(
                                                double.parse(item.latitude),
                                                double.parse(item.longitude)),
                                            icon: customIcon,
                                            onClick: () {
                                              setState(() {
                                                _selectedBranch = item;
                                                isCardShowing = true;
                                              });
                                            }));
                                        controller.animateCamera(
                                            CameraUpdate.newCameraPosition(
                                          CameraPosition(
                                            bearing: 0,
                                            target: LatLng(
                                                double.parse(item.latitude),
                                                double.parse(item.longitude)),
                                            zoom: 10,
                                          ),
                                        ));
                                        selectedBranch = item.title;
                                        _controller.text = selectedBranch;
                                        viewList = false;
                                      });
                                    },
                                  ),
                                ),
                              );
                            },
                          ),
                        )
                      : SizedBox(
                          height: 0,
                        ),
                ],
              ),
            ),
          ),
        ),
        isCardShowing
            ? showCard(branchResponseEntity: _selectedBranch)
            : Container(),
      ],
    );
  }

  Widget showCard({BranchEntity branchResponseEntity}) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: LocationMarkerCard(
        branchResponseEntity: _selectedBranch,
        closeFunction: () {
          setState(() {
            isCardShowing = false;
          });
        }, //adaptiveScreen
      ),
    );
  }

  Widget _buildTextField() {
    String message = '';
    return LayoutBuilder(builder: (context, size) {
      TextSpan text = new TextSpan(
        text: _controller.text,
      );
      TextPainter tp = new TextPainter(
        text: text,
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.left,
      );
      tp.layout(maxWidth: size.maxWidth);

      int lines = (tp.size.height / tp.preferredLineHeight).ceil();
      int maxLines = 1;

      return Scrollbar(
        child: TextField(
          scrollPhysics: BouncingScrollPhysics(),
          controller: _controller,
          maxLines: lines < maxLines ? null : maxLines,
          decoration: kSearchTextFieldDecoration,
          onChanged: (value) {
            message = value;
            setState(() {
              isCardShowing = false;
              viewList = true;
              selectedMarkers.clear();
              if (message.length >= 2) {
                searchFromList(message);
              } else {
                searchedList.clear();
              }
              selectedBranch = null;
            });
          },
          style: TextStyle(
              color: Color(0xffB2454545), fontWeight: FontWeight.w300),
        ),
      );
    });
  }

  void searchFromList(String message) {
    searchedList.clear();
    widget.branchData.forEach((data) {
      if (data.title.toLowerCase().contains(message.toLowerCase()))
        searchedList.add(data);
      setState(() {});
    });
  }
}
