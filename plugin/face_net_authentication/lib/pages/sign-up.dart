import 'dart:async';
import 'dart:io';
import 'dart:math' as math;
import 'package:face_net_authentication/pages/widgets/FacePainter.dart';
import 'package:face_net_authentication/pages/widgets/auth-action-button.dart';
import 'package:face_net_authentication/pages/widgets/camera_header.dart';
import 'package:face_net_authentication/services/camera.service.dart';
import 'package:face_net_authentication/services/facenet.service.dart';
import 'package:face_net_authentication/services/ml_kit_service.dart';
import 'package:camera/camera.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:flutter/material.dart';

class OpenCameraScan extends StatefulWidget {
  final CameraDescription cameraDescription;

  const OpenCameraScan({Key? key, required this.cameraDescription})
      : super(key: key);

  @override
  OpenCameraScanState createState() => OpenCameraScanState();
}

class OpenCameraScanState extends State<OpenCameraScan> {
  String? imagePath;
  Face? faceDetected;
  Size? imageSize;

  bool _detectingFaces = false;
  bool pictureTaked = false;

  Future? _initializeControllerFuture;
  bool cameraInitializated = false;

  // switchs when the user press the camera
  bool _saving = false;
  bool _bottomSheetVisible = false;

  // service injection
  MLKitService _mlKitService = MLKitService();
  CameraService _cameraService = CameraService();
  FaceNetService _faceNetService = FaceNetService();

  @override
  void initState() {
    super.initState();

    /// starts the camera & start framing faces
    _start();
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    _cameraService.dispose();
    super.dispose();
  }

  /// starts the camera & start framing faces
  _start() async {
    _initializeControllerFuture =
        _cameraService.startService(widget.cameraDescription);
    await _initializeControllerFuture;

    setState(() {
      cameraInitializated = true;
    });

    _frameFaces();
  }

  /// handles the button pressed event
  Future<bool> onShot() async {
    if (faceDetected == null) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text('未检测到人脸!'),
          );
        },
      );

      return false;
    } else {
      _saving = true;
      await Future.delayed(Duration(milliseconds: 500));
      await _cameraService.cameraController.stopImageStream();
      await Future.delayed(Duration(milliseconds: 200));
      XFile file = await _cameraService.takePicture();
      imagePath = file.path;
      setState(() {
        _bottomSheetVisible = true;
        pictureTaked = true;
        print("上传：" + imagePath!);
      });
      return true;
    }
  }

  /// draws rectangles when detects faces
  _frameFaces() {
    imageSize = _cameraService.getImageSize();

    _cameraService.cameraController.startImageStream((image) async {
      if (_cameraService.cameraController != null) {
        // 如果当前很忙，则避免过度处理
        if (_detectingFaces) return;
        _detectingFaces = true;

        try {
          List<Face> faces = await _mlKitService.getFacesFromImage(image);
          if (faces.length > 0) {
            setState(() {
              faceDetected = faces[0];
            });
            if (_saving) {
              _faceNetService.setCurrentPrediction(image, faceDetected!);
              setState(() {
                _saving = false;
              });
            }
          } else {
            faceDetected = null;
          }
          _detectingFaces = false;
        } catch (e) {
          print(e);
          _detectingFaces = false;
        }
      }
    });
  }

  _onBackPressed() {
    Navigator.of(context).pop();
  }

  _reload() {
    setState(() {
      _bottomSheetVisible = false;
      cameraInitializated = false;
      pictureTaked = false;
    });
    this._start();
  }

  @override
  Widget build(BuildContext context) {
    /// 框住脸
    final double mirror = math.pi;
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
        body: Stack(
          children: [
            FutureBuilder<void>(
              future: _initializeControllerFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (pictureTaked) {
                    return Transform.scale(
                        scale: 1.0,
                        child: Container(
                          alignment: Alignment.center,
                          child: ClipOval(
                            child: Container(
                                width: width / 1.2,
                                height: width / 1.2,
                                child: Stack(
                                  fit: StackFit.expand,
                                  children: <Widget>[
                                    Transform(
                                        alignment: Alignment.center,
                                        child: FittedBox(
                                          fit: BoxFit.cover,
                                          child: Image.file(
                                              File(imagePath!),
                                              alignment:Alignment.bottomCenter
                                          ),
                                        ),
                                        transform: Matrix4.rotationY(mirror))
                                  ],
                                )),
                          ),
                        ));
                  } else {
                    return Transform.scale(
                      scale: 1.0,
                      child: Container(
                        alignment: Alignment.center,
                        child: ClipOval(
                          child: Container(
                            width: width / 1.2,
                            height: width / 1.2,
                            child: Stack(
                              fit: StackFit.expand,
                              children: <Widget>[
                                CameraPreview(_cameraService.cameraController),
                                CustomPaint(
                                    painter: faceDetected != null
                                        ? FacePainter(
                                            face: faceDetected!,
                                            imageSize: imageSize!)
                                        : null),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
            CameraHeader(
              "人脸认证",
              onBackPressed: _onBackPressed,
            )
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: !_bottomSheetVisible
            ? AuthActionButton(
                _initializeControllerFuture!,
                onPressed: onShot,
                reload: _reload,
              )
            : Container());
  }
}
