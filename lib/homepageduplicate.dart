import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterapp1/water_wave_widget.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({super.key});

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  String title = 'Home'; // Add this line to track active tab
  double waterPercentage = 90.0; // Default value
  double waterAmount = 2.5; // Default value in ml
  String waterUnit = "L";

  // Bluetooth related variables
  BluetoothDevice? connectedDevice;
  BluetoothCharacteristic? characteristic;
  BluetoothCharacteristic? writeCharacteristic;
  String status = "Disconnected";
  //String volumeStr = "";
  //String percentStr = "";
  double _percent = 0.0;
  int _previousPercent = 0;

  double _volume = 0.0;
  double _previousVolume = 0.0;

  String _battery = "";

  //bool deviceFound = false;// Add this with your other Bluetooth-related variables
  List<String> responseParts = [];

  //   #define SERVICE_UUID       "4fafc201-1fb5-459e-8fcc-c5c9c331914b"
  // #define CHAR_BATT_UUID     "beb5483e-36e1-4688-b7f5-ea07361b26a8"
  // #define CHAR_ACK_UUID      "bb02c301-2eb3-4798-9cdd-dc45a5f7e123"

  // UART service and characteristic UUIDs (standard for many BLE devices)
  static String deviceName = "ESP32_BattSensor";
  static const String serviceUuid = "4fafc201-1fb5-459e-8fcc-c5c9c331914b";
  static const String rxCharUuid =
      "beb5483e-36e1-4688-b7f5-ea07361b26a8"; // to write
  static const String txCharUuid =
      "bb02c301-2eb3-4798-9cdd-dc45a5f7e123"; // to receive

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
    _requestPermissions();

    // Initialize Bluetooth
    FlutterBluePlus.adapterState.listen((state) async {
      if (state == BluetoothAdapterState.on) {
        // Bluetooth is on, we can scan
        print("Bluetooth adapter is ON");
        await connectAndDiscover();
      } else {
        // Bluetooth is off or unavailable
        setState(() => status = "Bluetooth is off");
      }
    });
  }

  Future<void> _requestPermissions() async {
    await [
      Permission.bluetooth,
      Permission.bluetoothScan,
      Permission.bluetoothConnect,
      Permission.locationWhenInUse,
    ].request();
  }

  Future<void> connectAndDiscover() async {
    // First check if we're already connected
    if (connectedDevice != null) {
      try {
        await connectedDevice!.disconnect();
      } catch (e) {
        print("Error disconnecting: $e");
      }
      setState(() {
        connectedDevice = null;
        characteristic = null;
        status = "Disconnected";
      });
    }

    // Show connecting dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircularProgressIndicator(),
              const SizedBox(height: 20),
              Text("Please wait, connecting to $deviceName..."),
            ],
          ),
        );
      },
    );

    setState(() => status = "Scanning...");

    try {
      // Make sure Bluetooth is on
      if (await FlutterBluePlus.isAvailable == false) {
        Navigator.of(context).pop(); // Close dialog
        setState(() => status = "Bluetooth not available");
        return;
      }

      if (await FlutterBluePlus.isOn == false) {
        Navigator.of(context).pop(); // Close dialog
        setState(() => status = "Please turn on Bluetooth");
        return;
      }

      // Start scanning
      await FlutterBluePlus.startScan(timeout: const Duration(seconds: 30));

      // Listen for scan results
      bool deviceFound = false;
      late StreamSubscription subscription;
      // Create a subscription to scan results

      final prefs = await SharedPreferences.getInstance();
      final lastConnectedDeviceId = prefs.getString('last_device_id');
      final lastConnectedDeviceName = prefs.getString('last_device_name');
      if (lastConnectedDeviceName != null && lastConnectedDeviceName != "") {
        deviceName = lastConnectedDeviceName;
      }
      subscription = FlutterBluePlus.scanResults.listen((results) {
        // Print all found devices for debugging
        for (ScanResult r in results) {
          print('Found device: ${r.device.advName} (${r.device.id})');

          // Check if this is our target device
          if (r.device.name == (deviceName)) {
            deviceFound = true;
            connectToDevice(r.device);
            subscription.cancel();
          }
        }
      });

      // After scan timeout, check if we found our device
      await Future.delayed(const Duration(seconds: 11));
      await subscription.cancel();

      if (!deviceFound) {
        Navigator.of(context).pop(); // Close dialog
        setState(() => status = "Device '$deviceName' not found");
        await FlutterBluePlus.stopScan();
      }
    } catch (e) {
      Navigator.of(context).pop(); // Close dialog
      print("Bluetooth error: $e");
      setState(() => status = "Error: ${e.toString()}");
      await FlutterBluePlus.stopScan();
    }
  }

  Future<void> connectToDevice(BluetoothDevice device) async {
    try {
      // Stop scanning once we find the device
      await FlutterBluePlus.stopScan();

      setState(() => status = "Connecting to ${device.advName}...");

      // Connect to the device
      await device.connect(timeout: const Duration(seconds: 5));
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('last_device_id', device.remoteId.str);
      await prefs.setString('last_device_name', device.advName);
      setState(() {
        connectedDevice = device;
        status = "Discovering services...";
      });

      // Discover services
      List<BluetoothService> services = await device.discoverServices();
      bool foundService = false;

      for (BluetoothService service in services) {
        print("Found service: ${service.uuid}");

        // Check if this is our target service
        if (service.uuid.toString().toLowerCase() ==
            serviceUuid.toLowerCase()) {
          foundService = true;
          print("Found target service!");

          // Look for our characteristic
          for (BluetoothCharacteristic c in service.characteristics) {
            print("Found characteristic: ${c.uuid}");

            // This is our RX characteristic (for writing)
            if (c.uuid.toString().toLowerCase() == txCharUuid.toLowerCase()) {
              setState(() => status = "Setting up characteristic...");
              writeCharacteristic = c;
              print("Found write characteristic!");
            }

            // This is our TX characteristic (for notifications)
            if (c.uuid.toString().toLowerCase() == rxCharUuid.toLowerCase()) {
              print("Found notification characteristic!");

              // Set up notifications immediately
              characteristic = c;

              c.onValueReceived.listen((data) {
                if (data.isNotEmpty) {
                  final msg = String.fromCharCodes(data).split(";");
                  // print("Received data: $msg");
                  // Use RegExp to find key = value pairs

                  setState(() {
                    // _battery = msg[0].split("=")[1];
                    // final volumeStr = msg[1]
                    //     .split("=")[1]
                    //     .replaceAll(RegExp(r'[^\d.]'), '');
                    // final parsedVolume = double.tryParse(volumeStr);
                    // if (parsedVolume != null) {
                    //   _previousVolume = _volume;
                    //   _volume = parsedVolume;
                    // }
                    // final percentStr = msg[2].split("=")[1].replaceAll("%", "");
                    // final parsedPercent = double.tryParse(percentStr);
                    // if (parsedPercent != null) {
                    //   _previousPercent = (_percent * 100).round();
                    //   _percent = parsedPercent / 100;
                    // }
                  });

                  /*if (msg.contains("%")) {
                    setState(() {
                      _battery = msg.trim();  // Ensure no extra whitespace
                    });

                  } else if (msg.contains("mL")) {
                    setState(() {
                      _volume = msg.trim();  // Ensure no extra whitespace
                    });

                  }else if (msg.contains("%")) {
                    setState(() {
                      _percent = msg.trim();  // Ensure no extra whitespace
                    });
                  }*/

                  print(
                    "Current values -> Volume: $_volume | Percent: $_percent | Battery: $_battery",
                  );
                }
              });

              await characteristic?.setNotifyValue(true);
            }
          }

          if (characteristic != null) {
            // Close the dialog
            Navigator.of(context).pop();
            setState(() => status = "Connected ✅");
            return;
          }
        }
      }

      // Close the dialog
      Navigator.of(context).pop();

      if (!foundService) {
        setState(() => status = "Service UUID not found");
      } else {
        setState(() => status = "Characteristic not found");
      }
    } catch (e) {
      // Close the dialog
      Navigator.of(context).pop();

      print("Connection error: $e");
      setState(() => status = "Connection failed: ${e.toString()}");

      // Try to disconnect in case of partial connection
      if (connectedDevice != null) {
        try {
          await connectedDevice!.disconnect();
        } catch (_) {}
        setState(() {
          connectedDevice = null;
          characteristic = null;
        });
      }
    }
  }

  Future<void> startMeasurement() async {
    if (characteristic == null) {
      setState(() => status = "Not connected");
      return;
    }

    try {
      setState(() {
        _volume = 0;
        _percent = 0;
        status = "Measuring...";
      });

      characteristic?.onValueReceived.listen((data) {
        if (data.isNotEmpty) {
          final msg = String.fromCharCodes(data).split(";");
          // print("Received data: $msg");

          // Use RegExp to find key = value pairs

          setState(() {
            _battery = msg[0].split("=")[1];
            final volumeStr = msg[1]
                .split("=")[1]
                .replaceAll(RegExp(r'[^\d.]'), '');
            final parsedVolume = double.tryParse(volumeStr);
            if (parsedVolume != null) {
              _previousVolume = _volume;
              _volume = parsedVolume;
            }
            final percentStr = msg[2].split("=")[1].replaceAll("%", "");
            final parsedPercent = double.tryParse(percentStr);
            if (parsedPercent != null) {
              _previousPercent = (_percent * 100).round();
              _percent = parsedPercent / 100;
            }
          });

          /*if (msg.contains("%")) {
                    setState(() {
                      _battery = msg.trim();  // Ensure no extra whitespace
                    });

                  } else if (msg.contains("mL")) {
                    setState(() {
                      _volume = msg.trim();  // Ensure no extra whitespace
                    });

                  }else if (msg.contains("%")) {
                    setState(() {
                      _percent = msg.trim();  // Ensure no extra whitespace
                    });
                  }*/

          print(
            "Current values -> Volume: $_volume | Percent: $_percent | Battery: $_battery",
          );
        }
      });
      await characteristic?.setNotifyValue(true);

      // Send the START command
      // await characteristic!.write(utf8.encode("START"));
      /*characteristic ?.onValueReceived.listen((data) {
                        if (data.isNotEmpty) {
                              String msg = String.fromCharCodes(data).trim();
                              print("Received data: $msg");

                              // Use RegExp to find key = value pairs
                              final matches = RegExp(r'(\w+)\s*=\s*([^\s,]+(?:\s*\w+|%))').allMatches(msg);

                              for (final match in matches) {
                                final key = match.group(1)?.toLowerCase();
                                final value = match.group(2)?.trim();
                          
                          /* Process the received data based on the format
                          if (msg.contains("battery =")) {
                            // Extract just the value part with its unit
                            final batteryValue = msg.split("battery =")[1].trim();
                            setState(() {
                              _battery = batteryValue;  // This will be "18%"
                            });
                          } else if (msg.contains("volumn =")) {
                            // Extract just the value part with its unit
                            final volumeValue = msg.split("volumn =")[1].trim();
                            setState(() {
                              _volume = volumeValue;  // This will be "450 ml"
                            });
                          } else if (msg.contains("percent =")) {
                            // Extract just the value part with its unit
                            final percentValue = msg.split("percent =")[1].trim();
                            setState(() {
                              _percent = percentValue;  // This will be "100%"
                            });
                          }*/

                          if (key == 'battery' && value != null) {
                                setState(() => _battery = value); // e.g. "18%"
                              } else if (key == 'volumn' && value != null) {
                                setState(() => _volume = value); // e.g. "450 ml"
                              } else if (key == 'percent' && value != null) {
                                setState(() => _percent = value); // e.g. "100%"
                              }
                            }
                          
                          // Debug print to verify values are being set
                          //print("Current values - Volume: '$_volume', Percent: '$_percent', Battery: '$_battery'");
                          print("Current values -> Volume: $_volume | Percent: $_percent | Battery: $_battery");
                        }
                      });
                      await characteristic ?.setNotifyValue(true);
                      print("START command sent");*/
    } catch (e) {
      print("Write error: $e");
      setState(() => status = "Command failed: ${e.toString()}");
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    // Disconnect from device when widget is disposed
    connectedDevice?.disconnect();
    super.dispose();
  }

  Future<void> sendSleepAckToBottle() async {
    try {
      await writeCharacteristic?.write("ACK".codeUnits);
      connectedDevice = null; // Clear the connected device after sending ack
      characteristic = null; // Clear the characteristic
      writeCharacteristic = null; // Clear the write characteristic
    } catch (e) {
      debugPrint("Error sending sleep ack: $e");
      setState(() => status = "Failed to send sleep ack");
    } finally {
      await Future.delayed(const Duration(seconds: 5), () {
        connectAndDiscover();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = constraints.maxWidth;
        final screenHeight = constraints.maxHeight;

        return Scaffold(
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.stop_circle),
            onPressed: () {
              sendSleepAckToBottle();
            },
          ),
          body: SingleChildScrollView(
            child: Container(
              width: double.infinity,
              constraints: BoxConstraints(minHeight: screenHeight),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFFB586BE), Color(0xFF131313)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                children: [
                  /// Top Greeting Section
                  Padding(
                    padding: EdgeInsets.only(
                      left: screenWidth * 0.08,
                      right: screenWidth * 0.05,
                      top: screenHeight * 0.09,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Good Morning",
                              style: TextStyle(
                                fontSize: screenWidth * 0.040,
                                fontFamily: 'MuseoModerno-Medium',
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.006),
                            Text(
                              "Newton Singh",
                              style: TextStyle(
                                fontSize: screenWidth * 0.058,
                                fontFamily: 'MuseoModerno-Bold',
                                color: const Color(0xFF141A1E),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),

                        /// Progress Indicator with Red Dot
                        Padding(
                          padding: EdgeInsets.only(
                            top: screenWidth * 0.03,
                            right: screenWidth * 0.08,
                          ),
                          child: Stack(
                            alignment: Alignment.center,
                            clipBehavior: Clip.none,
                            children: [
                              Positioned(
                                top: -screenWidth * 0.04,
                                child: BreathingRedDot(
                                  size: screenWidth * 0.025,
                                  borderColor: Color(0xFF9677E9),
                                  borderWidth: 1.0.w,
                                  isConnected: connectedDevice != null,
                                ),
                              ),
                              CustomCircularProgress(
                                progress:
                                    _battery.isNotEmpty
                                        ? double.parse(_battery.split('%')[0]) /
                                            100
                                        : 0.0,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.010),

                  /// Weather and Reminder
                  Padding(
                    padding: EdgeInsets.only(
                      left: screenWidth * 0.06,
                      right: screenWidth * 0.04,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            /*Image.asset(
                              'assets/sun.png',
                              width: screenWidth * 0.090,
                              height: screenWidth * 0.090,
                            
                            ),*/
                            ShaderMask(
                              shaderCallback: (Rect bounds) {
                                return LinearGradient(
                                  colors: [
                                    Color(0xFFFFE475),
                                    Color(0xFFFFBF29),
                                  ],
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                ).createShader(bounds);
                              },
                              blendMode: BlendMode.dstIn,
                              child: Image.asset(
                                'assets/sun.png',
                                width: screenWidth * 0.090,
                                height: screenWidth * 0.090,
                              ),
                            ),
                            Text(
                              "26°C",
                              style: TextStyle(
                                fontSize: screenWidth * 0.035,
                                fontFamily: 'Poppins-SemiBold',
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: screenWidth * 0.020),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.zero,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text: "It's a ",
                                        style: TextStyle(
                                          fontSize: screenWidth * 0.032,
                                          fontFamily: 'MuseoModerno-Regular',
                                          color: Colors.white,
                                        ),
                                      ),
                                      TextSpan(
                                        text: "Sunny Day",
                                        style: TextStyle(
                                          fontSize: screenWidth * 0.032,
                                          fontFamily: 'MuseoModerno-SemiBold',
                                          color: Colors.white,
                                        ),
                                      ),
                                      TextSpan(
                                        text: " today!",
                                        style: TextStyle(
                                          fontSize: screenWidth * 0.032,
                                          fontFamily: 'MuseoModerno-Regular',
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                  textAlign: TextAlign.start,
                                ),
                                Text(
                                  "Remember to stay hydrated throughout the day",
                                  style: TextStyle(
                                    fontSize: screenWidth * 0.032,
                                    fontFamily: 'museoModerno-Medium',
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  Container(
                    height: screenHeight * 0.08,
                    margin: EdgeInsets.only(
                      left: screenWidth * 0.08,
                      right: screenWidth * 0.08,
                      //bottom: screenHeight * 0.02,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(90.r),
                      gradient: const LinearGradient(
                        colors: [Color(0xFF3F3F3F), Color(0xFFFFFFFF)],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(2, 2),
                          color: Colors.black.withOpacity(0.25),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(1),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(90.r),
                          color: Color(0xFF8E76AE),
                        ),

                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.03,
                            vertical: screenHeight * 0.013,
                          ),
                          child: Row(
                            children: [
                              Image.asset(
                                'assets/water drop.png',
                                width: screenWidth * 0.065,
                                height: screenWidth * 0.07,
                              ),
                              SizedBox(width: screenWidth * 0.04),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "Water",
                                    style: TextStyle(
                                      fontSize: screenWidth * 0.03,
                                      fontFamily: 'Urbanist-Medium',
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(
                                    height: screenHeight * 0.005,
                                  ), // 4px spacing
                                  Text(
                                    "500ml",
                                    style: TextStyle(
                                      fontSize: screenWidth * 0.04,
                                      fontFamily: 'Urbanist-Bold',
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(width: screenWidth * 0.04),

                              Padding(
                                padding: const EdgeInsets.all(1),
                                child: Container(
                                  height: screenHeight * 0.032,
                                  width: screenWidth * 0.28,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(90.r),
                                    color: Color(0xFFBD95D1),
                                    border: Border.all(
                                      color: Color(0xFFFFFCFC),
                                      width: 1.w,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        offset: Offset(0, 4),
                                        color: Colors.black.withOpacity(0.25),
                                        blurRadius: 4,
                                        //spreadRadius: 1,
                                      ),
                                    ],
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                      left: screenWidth * 0.00,
                                      right: screenHeight * 0.00,
                                    ),
                                    child: ElevatedButton(
                                      onPressed:
                                          status == "Connected ✅"
                                              ? null
                                              : connectAndDiscover,
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            status == "Connected ✅"
                                                ? Colors.green
                                                : Colors.lightBlue,
                                      ),
                                      child: Text(
                                        status == "Connected ✅"
                                            ? "Connected"
                                            : "Connect",
                                        style: TextStyle(
                                          fontSize: screenWidth * 0.028,
                                          fontFamily: 'Urbanist-Bold',
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: screenWidth * 0.04),
                              Container(
                                height: screenHeight * 0.032,
                                width: screenWidth * 0.15,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(90.r),
                                ),
                                child: ElevatedButton(
                                  onPressed:
                                      characteristic != null
                                          ? startMeasurement
                                          : null,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        characteristic != null
                                            ? Colors.blue
                                            : Colors.grey,
                                    elevation: 0,
                                    padding: EdgeInsets.zero,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(90.r),
                                    ),
                                  ),
                                  child: Text(
                                    "Start",
                                    style: TextStyle(
                                      fontSize: screenWidth * 0.022,
                                      fontFamily: 'Urbanist-SemiBold',
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: screenHeight * 0.009),

                  /// Bottle + Wave + Circular Text Progress
                  Center(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Image.asset(
                          'assets/home page bottle image1.png',
                          width: screenWidth * 0.93,
                          height: screenHeight * 0.4,
                          fit: BoxFit.contain,
                        ),
                        Positioned(
                          bottom: screenHeight * 0.18,
                          child: Container(
                            width: screenWidth * 0.13,
                            height: screenHeight * 0.11,
                            margin: EdgeInsets.only(right: 2.w),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(100.r),
                              boxShadow: [
                                BoxShadow(
                                  offset: Offset(4, 4),
                                  color: Color(0xFF000000).withOpacity(0.25),
                                  blurRadius: 4,
                                  //spreadRadius: 1,
                                ),
                              ],
                            ),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                SizedBox(
                                  width: 55.w,
                                  height: 100.h,
                                  child: WaterWaveWidget(
                                    orientation: Axis.horizontal,
                                    fillPercent: _percent,
                                    speed: Duration(seconds: 3),
                                    amplitude: 4,
                                    waveCount: 3,
                                  ),
                                ),

                                // ClipRRect(
                                //   borderRadius: BorderRadius.circular(100.r),

                                // child: WaveWidget(
                                //   config: CustomConfig(
                                //     colors: [
                                //       const Color(
                                //         0xFFB3F0F8,
                                //       ).withOpacity(0.6),
                                //       const Color(
                                //         0xFF70D6ED,
                                //       ).withOpacity(0.5),
                                //       const Color.fromARGB(255, 14, 26, 31).withOpacity(0.4),
                                //       const Color(
                                //         0xFF005D84,
                                //       ).withOpacity(0.3),
                                //     ],
                                //     durations: [
                                //       5000,
                                //       5500,
                                //       6000,
                                //       6500,
                                //     ], // Much faster wave animation
                                //     heightPercentages:
                                //         _percent.isNotEmpty
                                //             ? [
                                //               1.0 -
                                //                   (double.tryParse(
                                //                             _percent
                                //                                 .replaceAll(
                                //                                   '%',
                                //                                   '',
                                //                                 ),
                                //                           ) ??
                                //                           0) /
                                //                       100,
                                //               1.0 -
                                //                   (double.tryParse(
                                //                             _percent
                                //                                 .replaceAll(
                                //                                   '%',
                                //                                   '',
                                //                                 ),
                                //                           ) ??
                                //                           0) /
                                //                       100 -
                                //                   0.01,
                                //               1.0 -
                                //                   (double.tryParse(
                                //                             _percent
                                //                                 .replaceAll(
                                //                                   '%',
                                //                                   '',
                                //                                 ),
                                //                           ) ??
                                //                           0) /
                                //                       100 -
                                //                   0.02,
                                //               1.0 -
                                //                   (double.tryParse(
                                //                             _percent
                                //                                 .replaceAll(
                                //                                   '%',
                                //                                   '',
                                //                                 ),
                                //                           ) ??
                                //                           0) /
                                //                       100 -
                                //                   0.03,
                                //             ]
                                //             : [0.90, 0.89, 0.88, 0.87],
                                //   ),
                                //   waveAmplitude: 1,
                                //   backgroundColor: Colors.transparent,
                                //   size: const Size(
                                //     double.infinity,
                                //     double.infinity,
                                //   ),
                                //   waveFrequency:
                                //       0.8, // Negative for right-to-left direction
                                //   isLoop: true,
                                // ),
                                // ),
                                TweenAnimationBuilder<int>(
                                  tween: IntTween(
                                    begin: _previousPercent,
                                    end: (_percent * 100).round(),
                                  ),
                                  duration: Duration(milliseconds: 1000),
                                  curve: Curves.easeOut,
                                  builder: (context, value, child) {
                                    return Text(
                                      "$value%",
                                      style: TextStyle(
                                        fontSize: 20.sp,
                                        fontFamily: 'MuseoModerno-Medium',
                                        color: Color(0xFF12121A),
                                        letterSpacing: -2.0,
                                      ),
                                    );
                                  },
                                ),
                                Container(
                                  padding: EdgeInsets.only(
                                    top: screenHeight * 0.07,
                                  ),
                                  child: TweenAnimationBuilder<double>(
                                    tween: Tween<double>(
                                      begin: _previousVolume,
                                      end: _volume,
                                    ),
                                    duration: Duration(milliseconds: 1000),
                                    curve: Curves.easeOut,
                                    builder: (context, value, child) {
                                      return Text(
                                        "${value.toStringAsFixed(0)} ml",
                                        style: TextStyle(
                                          fontSize: 10.sp,
                                          fontFamily: 'MuseoModerno-semiBold',
                                          color: Color(0xFF12121A),
                                          letterSpacing: 1.0,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: screenHeight * 0.055,
                          left: screenWidth * 0.39,
                          child: CircularLoadingAnimation(
                            size: screenWidth * 0.14,
                            strokeWidth: screenWidth * 0.015,
                            centerText: "2.5L\n/0.15L",
                            percentage: waterPercentage / 100,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.001),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.04,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text:
                                    "You got 50% of today’s goal, keep focus\non your health!",
                                style: TextStyle(
                                  fontSize: screenWidth * 0.04,
                                  fontFamily: 'MuseoModerno-Medium',
                                  color: Color(0xFFFDFEFF),
                                  shadows: [
                                    Shadow(
                                      offset: Offset(0, 3),
                                      blurRadius: 8,
                                      color: Color(0x40000000),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: screenHeight * 0.06),

                  /// Bottom Navigation
                  Container(
                    height: screenHeight * 0.09,
                    //width: screenWidth * 0.09,
                    margin: EdgeInsets.only(
                      left: screenWidth * 0.05,
                      right: screenWidth * 0.05,
                      bottom: screenHeight * 0.0,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(90.r),
                      gradient: const LinearGradient(
                        colors: [Color(0xFF3F3F3F), Color(0xFFFFFFFF)],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(1.w),
                      child: Container(
                        padding: EdgeInsets.only(
                          left: screenHeight * 0.007.w,
                          right: screenHeight * 0.006.w,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF2B2536),
                          borderRadius: BorderRadius.circular(90.r),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _buildNavItem(
                              Icons.home,
                              'Home',
                              title == 'Home',
                              screenWidth,
                              screenHeight,
                            ),
                            _buildNavItem(
                              Icons.analytics_outlined,
                              'Analysis',
                              title == 'Analysis',
                              screenWidth,
                              screenHeight,
                            ),
                            _buildNavItem(
                              Icons.lightbulb_outline,
                              'Goals',
                              title == 'Goals',
                              screenWidth,
                              screenHeight,
                            ),
                            _buildNavItem(
                              Icons.settings,
                              'Settings',
                              title == 'Settings',
                              screenWidth,
                              screenHeight,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildNavItem(
    IconData icon,
    String label,
    bool isActive,
    double screenWidth,
    double screenHeight,
  ) {
    final assetPath = 'assets/${label.toLowerCase()}.png';
    double scale = 1.0;

    return StatefulBuilder(
      builder: (context, setState) {
        return GestureDetector(
          onTapDown: (_) => setState(() => scale = 0.9),
          onTapUp: (_) => setState(() => scale = 1.0),
          onTapCancel: () => setState(() => scale = 1.0),
          onTap: () {
            debugPrint('Tapped on: $label');
            _handleBottomNavigation(label);
          },
          child: AnimatedScale(
            scale: scale,
            duration: const Duration(milliseconds: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: screenWidth * 0.2,
                  height: screenHeight * 0.06,
                  decoration: BoxDecoration(
                    gradient:
                        isActive
                            ? const LinearGradient(
                              colors: [Color(0xFFFAFAFA), Color(0xFF3E3E3E)],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            )
                            : null,
                    color: isActive ? null : Colors.transparent,
                    borderRadius: BorderRadius.circular(48.r),
                    boxShadow: [
                      BoxShadow(
                        offset: const Offset(4, 4),
                        color:
                            isActive
                                ? const Color(0x40000000)
                                : Colors.transparent,
                        blurRadius: 4,
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: Container(
                      width: screenWidth * 0.19,
                      height: screenHeight * 0.055,
                      decoration: BoxDecoration(
                        gradient:
                            isActive
                                ? const LinearGradient(
                                  colors: [
                                    Color(0xFFB182BA),
                                    Color(0xFF2D1B31),
                                  ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                )
                                : null,
                        color: isActive ? null : Colors.transparent,
                        borderRadius: BorderRadius.circular(46),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            assetPath,
                            width: screenWidth * 0.06,
                            height: screenWidth * 0.06,
                            color: Colors.white,
                            errorBuilder: (context, error, stackTrace) {
                              debugPrint(
                                'Error loading image: $assetPath - $error',
                              );
                              return Icon(
                                icon,
                                size: screenWidth * 0.055,
                                color: Colors.white,
                              );
                            },
                          ),
                          Text(
                            label,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: screenWidth * 0.03,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  /* Widget _buildNavItem(
    IconData icon,
    String label,
    bool isActive,
    double screenWidth,
    double screenHeight,
  ) {
    final assetPath = 'assets/${label.toLowerCase()}.png';
    double scale = 1.0;

    return StatefulBuilder(
      builder: (context, setState) {
        return GestureDetector(
          onTapDown: (_) => setState(() => scale = 0.70),
          onTapUp: (_) => setState(() => scale = 0.90),
          onTapCancel: () => setState(() => scale = 0.90),
          onTap: () {
            debugPrint('Tapped on: $label');
            _handleBottomNavigation(label);
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: screenWidth * 0.2,
                height: screenHeight * 0.06,
                decoration: BoxDecoration(
                  gradient:
                      isActive
                          ? const LinearGradient(
                            colors: [Color(0xFFFAFAFA), Color(0xFF3E3E3E)],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          )
                          : null,
                  color: isActive ? null : Colors.transparent,
                  borderRadius: BorderRadius.circular(48.r),
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(4, 4),
                      color:
                          isActive
                              ? const Color(0x40000000)
                              : Colors.transparent,
                      blurRadius: 4,
                    ),
                  ],
                ),
                child: AnimatedScale(
                  scale: scale,
                  duration: const Duration(milliseconds: 100),
                  child: Padding(
                    padding: EdgeInsets.all(1.r),
                    child: Container(
                      width: screenWidth * 0.19,
                      height: screenHeight * 0.055,
                      decoration: BoxDecoration(
                        gradient:
                            isActive
                                ? const LinearGradient(
                                  colors: [
                                    Color(0xFFB182BA),
                                    Color(0xFF2D1B31),
                                  ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                )
                                : null,
                        color: isActive ? null : Colors.transparent,
                        borderRadius: BorderRadius.circular(46.r),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            assetPath,
                            width: screenWidth * 0.06,
                            height: screenWidth * 0.06,
                            color: Colors.white,
                            errorBuilder: (context, error, stackTrace) {
                              debugPrint(
                                'Error loading image: $assetPath - $error',
                              );
                              return Icon(
                                icon,
                                size: screenWidth * 0.055,
                                color: Colors.white,
                              );
                            },
                          ),
                          Text(
                            label,
                            style: TextStyle(
                              color: const Color(0xFFFFFFFF),
                              fontSize: screenWidth * 0.03,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }*/

  void _handleBottomNavigation(String label) {
    setState(() {
      title = label; // Update active tab
    });

    switch (label) {
      case 'Home':
        Navigator.pushNamed(context, '/homepage');
        break;
      case 'Analysis':
        Navigator.pushNamed(context, '/analysis');
        break;
      case 'Goals':
        Navigator.pushNamed(context, '/dailygoalpage');
        break;
      case 'Settings':
        Navigator.pushNamed(context, '/preferences');
        break;
      default:
        debugPrint('No route defined for $label');
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('$label screen coming soon!')));
    }
  }
}

// Circular Loading Animation Widget
class CircularLoadingAnimation extends StatefulWidget {
  final double size;
  final double strokeWidth;
  final String centerText;
  final double percentage;

  const CircularLoadingAnimation({
    super.key,
    this.size = 150.0,
    this.strokeWidth = 10.0,
    this.centerText = "/0.15L",
    this.percentage = 0.85,
  });

  @override
  State<CircularLoadingAnimation> createState() =>
      _CircularLoadingAnimationState();
}

class _CircularLoadingAnimationState extends State<CircularLoadingAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.size,
      height: widget.size,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: [Color(0xFFAD80B6), Color(0xFF323132)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        //color: Color(0xFF936FA7),
        boxShadow: [
          BoxShadow(
            offset: Offset(4, 4),
            blurRadius: 5,
            color: Color(0x40000000),
          ),
        ],
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return CustomPaint(
                size: Size(widget.size - 4.w, widget.size - 4.w),
                painter: _CircularProgressPainter(
                  progress: widget.percentage,
                  strokeWidth: widget.strokeWidth,
                  animation: _controller.value,
                ),
              );
            },
          ),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "${widget.centerText.split('\n')[0]}\n",
                  style: TextStyle(
                    color: Color(0xFFFFFFFF),
                    fontSize: widget.size * 0.22,
                    fontFamily: 'MuseoModerno-Bold',
                  ),
                ),
                TextSpan(
                  text: widget.centerText.split('\n')[1],
                  style: TextStyle(
                    color: const Color(0xFF9AE0DF),
                    fontFamily: 'MuseoModerno-Medium',
                    fontSize: widget.size * 0.16,
                  ),
                ),
              ],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _CircularProgressPainter extends CustomPainter {
  final double progress;
  final double strokeWidth;
  final double animation;

  _CircularProgressPainter({
    required this.progress,
    required this.strokeWidth,
    required this.animation,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;

    final shadowPaint =
        Paint()
          ..color = const Color(0x40000000) // Shadow color
          ..style = PaintingStyle.stroke
          ..strokeWidth = strokeWidth
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3);

    canvas.drawCircle(
      center.translate(3, 4),
      radius,
      shadowPaint,
    ); // Offset shadow

    final backgroundPaint =
        Paint()
          ..color = Color(0x1CFFFFFF)
          ..style = PaintingStyle.stroke
          ..strokeWidth = strokeWidth
          ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, backgroundPaint);

    final rect = Rect.fromCircle(center: center, radius: radius);
    final gradient = SweepGradient(
      colors: const [Color(0xFFFFFFFF), Color(0xFF00B5FF)],
      stops: const [0.0, 1.0],
      startAngle: 0,
      endAngle: 2 * pi,
      transform: GradientRotation(-pi / 1.8),
    );

    final progressPaint =
        Paint()
          ..shader = gradient.createShader(rect)
          ..style = PaintingStyle.stroke
          ..strokeWidth = strokeWidth
          ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2,
      2 * pi * progress,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _CircularProgressPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}

class CustomCircularProgress extends StatelessWidget {
  final double progress;

  const CustomCircularProgress({super.key, required this.progress});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 60.w,
      height: 60.w,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 60.w,
            height: 60.w,
            //padding: EdgeInsets.only(right: 5.w),
            decoration: BoxDecoration(
              color: const Color(0xFF896A98),
              shape: BoxShape.circle,
              border: Border.all(color: const Color(0x10896A98), width: 1.w),
              /*boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.25),
                  blurRadius: 4.r,
                  offset: const Offset(0, 4),
                ),
              ],*/
            ),
          ),
          SizedBox(
            width: 46.w,
            height: 46.w,
            child: CircularProgressIndicator(
              value: progress,
              strokeWidth: 5.8.w,
              backgroundColor: Color(0xFFDDECDC),
              valueColor: const AlwaysStoppedAnimation<Color>(
                Color(0xFF43E73E),
              ),
              strokeCap: StrokeCap.round,
            ),
          ),
          Text(
            "${(progress * 100).toInt()}%",
            style: TextStyle(
              fontSize: 13.sp,
              fontFamily: 'MuseoModerno-SemiBold',
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

class BreathingRedDot extends StatefulWidget {
  final double size;
  final Color borderColor;
  final double borderWidth;
  final bool isConnected;

  const BreathingRedDot({
    required this.size,
    required this.borderColor,
    required this.borderWidth,
    required this.isConnected,
    super.key,
  });

  @override
  State<BreathingRedDot> createState() => _BreathingRedDotState();
}

class _BreathingRedDotState extends State<BreathingRedDot>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);

    _scaleAnimation = Tween<double>(begin: 0.85, end: 1.15).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _opacityAnimation = Tween<double>(begin: 0.7, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: Opacity(
            opacity: _opacityAnimation.value,
            child: Container(
              width: widget.size,
              height: widget.size,
              decoration: BoxDecoration(
                color:
                    widget.isConnected ? Color(0xFF43E73E) : Color(0xFFFF0000),
                shape: BoxShape.circle,
                border: Border.all(
                  color: widget.borderColor,
                  width: widget.borderWidth,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.4),
                    blurRadius: 4,
                    spreadRadius: 1,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
