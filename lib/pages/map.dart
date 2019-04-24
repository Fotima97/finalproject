import 'dart:async';

import 'package:finalproject/helpers/hospitalsmodel.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Map extends StatefulWidget {
  Map({Key key, this.hospital}) : super(key: key);
  final HospitalModel hospital;

  _MapState createState() => _MapState();
}

class _MapState extends State<Map> {
  Completer<GoogleMapController> _controller = Completer();
  static HospitalModel _hosptial;
  Set<Marker> markers = Set();
  double zoomValue = 15.0;
  @override
  void initState() {
    _hosptial = widget.hospital;

    // TODO: implement initState
    super.initState();

    markers.add(Marker(
        markerId: MarkerId(_hosptial.title),
        position: LatLng(_hosptial.lat, _hosptial.long),
        infoWindow: InfoWindow(title: _hosptial.title),
        icon:
            BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        widget.hospital.title,
        style: TextStyle(fontSize: 14.0),
      )),
      body: Stack(
        children: <Widget>[
          _googleMap(context),
        ],
      ),
    );
  }

  Future<void> updateCamera(double value) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(widget.hospital.lat, widget.hospital.long),
        zoom: zoomValue)));
  }

  Widget _googleMap(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: CameraPosition(
              target: LatLng(widget.hospital.lat, widget.hospital.long),
              zoom: zoomValue),
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
          markers: markers),
    );
  }
}
