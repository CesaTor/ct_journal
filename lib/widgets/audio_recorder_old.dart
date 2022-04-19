// import 'dart:async';
//
// import 'package:flutter/material.dart';
// import 'package:record/record.dart';
//
// class AudioRecorderOld extends StatefulWidget {
//   final void Function(String path) onStop;
//
//   const AudioRecorderOld({required this.onStop});
//
//   @override
//   _AudioRecorderState createState() => _AudioRecorderState();
// }
//
// class _AudioRecorderState extends State<AudioRecorderOld> {
//   bool _isRecording = false;
//   // bool _isPaused = false;
//   int _recordDuration = 0;
//   Timer? _timer;
//   Timer? _ampTimer;
//   final _audioRecorder = Record();
//   // Amplitude? _amplitude;
//
//   @override
//   void initState() {
//     _isRecording = false;
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     _timer?.cancel();
//     _ampTimer?.cancel();
//     _audioRecorder.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//                 _buildRecordStopControl(),
//                 const SizedBox(width: 10),
//                 // _buildPauseResumeControl(),
//                 _buildText(),
//               ],
//             ),
//             // if (_amplitude != null) ...[
//             //   const SizedBox(height: 40),
//             //   Text('Current: ${_amplitude?.current ?? 0.0}'),
//             //   Text('Max: ${_amplitude?.max ?? 0.0}'),
//             // ],
//           ],
//     );
//   }
//
//   Widget _buildRecordStopControl() {
//     late Icon icon;
//     late Color color;
//
//     if (_isRecording) {
//     // if (_isRecording || _isPaused) {
//       icon = Icon(Icons.stop, color: Colors.red, size: 10);
//       color = Colors.red.withOpacity(0.1);
//     } else {
//       final theme = Theme.of(context);
//       icon = Icon(Icons.mic, color: theme.primaryColor, size: 10);
//       color = theme.primaryColor.withOpacity(0.1);
//     }
//
//     return ClipOval(
//       child: Material(
//         color: color,
//         child: InkWell(
//           child: SizedBox(width: 30, height: 30, child: icon),
//           onTap: () {
//             _isRecording ? _stop() : _start();
//           },
//         ),
//       ),
//     );
//   }
//
//   // Widget _buildPauseResumeControl() {
//   //   if (!_isRecording && !_isPaused) {
//   //     return const SizedBox.shrink();
//   //   }
//   //
//   //   late Icon icon;
//   //   late Color color;
//   //
//   //   if (!_isPaused) {
//   //     icon = const Icon(Icons.pause, color: Colors.red, size: 10);
//   //     color = Colors.red.withOpacity(0.1);
//   //   } else {
//   //     final theme = Theme.of(context);
//   //     icon = const Icon(Icons.play_arrow, color: Colors.red, size: 10);
//   //     color = theme.primaryColor.withOpacity(0.1);
//   //   }
//   //
//   //   return ClipOval(
//   //     child: Material(
//   //       color: color,
//   //       child: InkWell(
//   //         child: SizedBox(width: 30, height: 30, child: icon),
//   //         onTap: () {
//   //           _isPaused ? _resume() : _pause();
//   //         },
//   //       ),
//   //     ),
//   //   );
//   // }
//
//   Widget _buildText() {
//     // if (_isRecording || _isPaused) {
//     if (_isRecording) {
//       return _buildTimer();
//     }
//     return const Text("");
//     // return const Text("Waiting to record");
//   }
//
//   Widget _buildTimer() {
//     final String minutes = _formatNumber(_recordDuration ~/ 60);
//     final String seconds = _formatNumber(_recordDuration % 60);
//
//     return Text(
//       '$minutes : $seconds',
//       style: const TextStyle(color: Colors.red),
//     );
//   }
//
//   String _formatNumber(int number) {
//     String numberStr = number.toString();
//     if (number < 10) {
//       numberStr = '0' + numberStr;
//     }
//
//     return numberStr;
//   }
//
//   Future<void> _start() async {
//     try {
//       if (await _audioRecorder.hasPermission()) {
//         await _audioRecorder.start();
//
//         bool isRecording = await _audioRecorder.isRecording();
//         setState(() {
//           _isRecording = isRecording;
//           _recordDuration = 0;
//         });
//
//         _startTimer();
//       }
//     } catch (e) {
//       print(e);
//     }
//   }
//
//   Future<void> _stop() async {
//     _timer?.cancel();
//     _ampTimer?.cancel();
//     final path = await _audioRecorder.stop();
//
//     widget.onStop(path!);
//
//     setState(() => _isRecording = false);
//   }
//
//   // Future<void> _pause() async {
//   //   _timer?.cancel();
//   //   _ampTimer?.cancel();
//   //   await _audioRecorder.pause();
//   //
//   //   setState(() => _isPaused = true);
//   // }
//   //
//   // Future<void> _resume() async {
//   //   _startTimer();
//   //   await _audioRecorder.resume();
//   //
//   //   setState(() => _isPaused = false);
//   // }
//
//   void _startTimer() {
//     _timer?.cancel();
//     _ampTimer?.cancel();
//
//     _timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
//       setState(() => _recordDuration++);
//     });
//
//     _ampTimer =
//         Timer.periodic(const Duration(milliseconds: 200), (Timer t) async {
//           // _amplitude = await _audioRecorder.getAmplitude();
//           setState(() {});
//         });
//   }
// }