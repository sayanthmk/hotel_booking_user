import 'dart:io';
import 'package:hotel_booking/features/home/presentation/providers/selected_bloc/bloc/selectedhotel_bloc.dart';
import 'package:hotel_booking/features/report/presentation/pages/repor.dart';
import 'package:hotel_booking/features/report/presentation/providers/bloc/report_bloc.dart';
import 'package:hotel_booking/features/report/presentation/providers/bloc/report_event.dart';
import 'package:hotel_booking/features/report/presentation/providers/bloc/report_state.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReportIssuePage extends StatelessWidget {
  const ReportIssuePage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> predefinedIssues = [
      "Room cleanliness issue",
      "Faulty air conditioner",
      "Unresponsive hotel staff",
      "Incorrect booking details",
      "Noisy environment",
      "Wi-Fi not working",
      "Overcharging issues",
      "Uncomfortable bed",
      "Hygiene issue",
    ];

    final TextEditingController customIssueController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Report an Issue'),
        actions: [
          IconButton(
            icon: const Icon(Icons.help_outline),
            onPressed: () => _showHelpDialog(context),
          ),
          IconButton(
              icon: const Icon(Icons.report),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const ReportedIssuesPage(),
                ));
              }),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Select a predefined issue or describe your own:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Expanded(
              flex: 3,
              child: BlocBuilder<SelectedHotelBloc, SelectedHotelState>(
                builder: (context, hotelState) {
                  if (hotelState is SelectedHotelLoaded) {
                    final hotelId = hotelState.hotel.hotelId;
                    return ListView.builder(
                      itemCount: predefinedIssues.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: ListTile(
                            title: Text(predefinedIssues[index]),
                            trailing: const Icon(Icons.report_problem,
                                color: Colors.red),
                            onTap: () {
                              _submitIssue(
                                  context, predefinedIssues[index], hotelId);
                            },
                          ),
                        );
                      },
                    );
                  }
                  return const Center(child: CircularProgressIndicator());
                },
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: customIssueController,
                    decoration: InputDecoration(
                      hintText: 'Describe your custom issue',
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.send),
                        onPressed: () {
                          final customIssue = customIssueController.text.trim();
                          if (customIssue.isNotEmpty) {
                            final hotelId = (context
                                    .read<SelectedHotelBloc>()
                                    .state as SelectedHotelLoaded)
                                .hotel
                                .hotelId;
                            _submitIssue(context, customIssue, hotelId);
                            customIssueController.clear();
                          }
                        },
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    maxLines: 2,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.camera_alt),
                  onPressed: () => _showImageSourceDialog(context),
                ),
              ],
            ),
            BlocBuilder<ReportIssueBloc, ReportIssueState>(
              builder: (context, state) {
                if (state is ReportIssueImageUploadedState) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Image.network(
                      state.imageUrl,
                      height: 100,
                      width: 100,
                      fit: BoxFit.cover,
                    ),
                  );
                }
                return const SizedBox();
              },
            ),
            BlocConsumer<ReportIssueBloc, ReportIssueState>(
              listener: (context, state) {
                if (state is ReportIssueSuccessState) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.successMessage),
                      backgroundColor: Colors.green,
                    ),
                  );
                } else if (state is ReportIssueFailureState) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.errorMessage),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              builder: (context, state) {
                if (state is ReportIssueLoadingState) {
                  return const Center(child: CircularProgressIndicator());
                }
                return const SizedBox();
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showImageSourceDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Choose Image Source'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera),
              title: const Text('Camera'),
              onTap: () {
                Navigator.of(context).pop();
                _pickImage(context, ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Gallery'),
              onTap: () {
                Navigator.of(context).pop();
                _pickImage(context, ImageSource.gallery);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _pickImage(BuildContext context, ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      final File imageFile = File(pickedFile.path);

      // Get the current hotel ID
      final hotelId =
          (context.read<SelectedHotelBloc>().state as SelectedHotelLoaded)
              .hotel
              .hotelId;

      // Dispatch image upload event
      context.read<ReportIssueBloc>().add(ReportIssueImageEvent(imageFile));
    }
  }

  void _submitIssue(BuildContext context, String issueContent, String hotelId,
      {File? imageFile}) {
    context.read<ReportIssueBloc>().add(
          SubmitReportEvent(
            issueContent: issueContent,
            hotelId: hotelId,
            imageFile: imageFile,
          ),
        );
  }

  void _showHelpDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Reporting an Issue'),
        content: const Text(
          'You can:\n'
          '• Select a predefined issue\n'
          '• Write a custom issue description\n'
          '• Provide specific details about your problem\n'
          '• Add a supporting image\n'
          'Our staff will review and address your concern promptly.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Understood'),
          ),
        ],
      ),
    );
  }
}
