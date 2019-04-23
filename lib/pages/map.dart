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
  double zoomValue = 5.0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _hosptial = widget.hospital;
    markers.add(hospitalMarker);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _googleMap(context),
          _zoomMinusFunction(),
          _zoomPlusFunction(),
        ],
      ),
    );
  }

  Marker hospitalMarker = Marker(
      markerId: MarkerId(_hosptial.title),
      position: LatLng(_hosptial.lat, _hosptial.long),
      infoWindow: InfoWindow(title: _hosptial.title),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet));

  Widget _zoomMinusFunction() {
    return Align(
      alignment: Alignment.topLeft,
      child: IconButton(
        icon: Icon(FontAwesomeIcons.searchMinus),
        color: Color(0xff6200ee),
        onPressed: () {
          zoomValue--;
          updateCamera(zoomValue);
        },
      ),
    );
  }

  Widget _zoomPlusFunction() {
    return Align(
      alignment: Alignment.topRight,
      child: IconButton(
        icon: Icon(FontAwesomeIcons.searchMinus),
        color: Color(0xff6200ee),
        onPressed: () {
          zoomValue++;
          updateCamera(zoomValue);
        },
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
