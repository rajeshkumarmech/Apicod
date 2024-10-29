import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  String gender = 'Select Gender';
  Future<void> getapi() async {
    String api = 'https://chitsoft.in/wapp/api/mobile3/purches_chit_17.php';
    final response = await http.post(
      Uri.parse(api),
      // headers: {
      //   'Content-Type': 'application/json',
      // },
      body: ({
        'type': '55',
        'cid': '11',
        'mobile': '9876543210',
        'email': 'dinesh@example.com'
      }),
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      if (responseData['error'] == false) {
        final availableChits = responseData['available_chits'];

        final chit = availableChits[0];

        setState(() {
          nameController.text = chit['Name'];
          phoneController.text = chit['Mobile'];
          emailController.text = chit['Email'];
          addressController.text = chit['Address'];
          gender = chit['Gender'] ?? 'Select Gender';
        });

        availableChits.forEach((chit) {
          print("Name: ${chit['Name']}");
          print("Mobile: ${chit['Mobile']}");
          print("Email: ${chit['Email']}");
          print("Address: ${chit['Address']}");
          print("Gender: ${chit['Gender']}");
        });
      } else {
        print("Error: ${responseData['error_msg']}");
      }
    }
  }

  @override
  void initState() {
    super.initState();

    // nameController.text = '';
    // emailController.text = 'dinesh@example.com';
    // phoneController.text = '9876543210';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            // Background Image
            Positioned.fill(
              child: Image.asset(
                'images/AfterBG.jpeg'
                //'assets/foxlbg.jpeg'
                , // Replace with your background image asset path
                fit: BoxFit
                    .cover, // Ensure the image covers the entire background
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  AppBar(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    leading: Container(),
                    centerTitle: true, // Center the title
                    title: const Text(
                      'User Profile',
                      style: TextStyle(color: Colors.white),
                    ),
                    actions: [
                      IconButton(
                        icon: const Icon(Icons.notifications,
                            color: Colors.white),
                        onPressed: () {},
                      )
                    ],
                  ),
                ],
              ),
            ),
            // Main content over the background
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  // AppBar aligned at the top using SafeArea
                  const SizedBox(height: 100),
                  const Center(
                    child: Stack(
                      children: [
                        CircleAvatar(
                          radius: 55,
                          backgroundColor: Colors.white,
                          child: CircleAvatar(
                            radius: 52,
                            backgroundImage: AssetImage(
                                //'assets/img.png'
                                'images/AfterBG.jpeg'), // Replace with your image
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Icon(
                            Icons.edit,
                            color: Colors.blue,
                            size: 24,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  buildTextField('Name', nameController, false),
                  buildTextField('Contact Number', phoneController, true),
                  buildTextField('E-mail ID', emailController, false),
                  buildTextField('Address', addressController, false,
                      maxLines: 3),
                  buildDropdownButton(),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      // Handle Update action
                      getapi();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 60, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text('Update',
                        style: TextStyle(color: Colors.white, fontSize: 18)),
                  ),
                  const SizedBox(height: 120),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTextField(
      String labelText, TextEditingController controller, bool isPhone,
      {int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextField(
        controller: controller,
        keyboardType: isPhone ? TextInputType.phone : TextInputType.text,
        maxLines: maxLines, // Set maximum lines for address
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          labelText: labelText,
          hintText: labelText == 'Address'
              ? 'Enter your Address'
              : null, // Add hint text specifically for the Address field
          hintStyle: const TextStyle(color: Colors.grey), // Hint text style
          hintMaxLines: 1, // Ensure hint stays on a single line
          labelStyle: const TextStyle(color: Colors.grey),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10), // Rounded border
            borderSide: const BorderSide(
                color: Colors.grey, width: 1.5), // Adjust border width
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
                color: Colors.grey, width: 2), // Focused border with blue color
          ),
          suffixIcon: isPhone || labelText == 'E-mail ID'
              ? TextButton(
                  onPressed: () {
                    // Handle change action
                  },
                  child:
                      const Text('CHANGE', style: TextStyle(color: Colors.red)),
                )
              : null,
        ),
      ),
    );
  }

  Widget buildDropdownButton() {
    return DropdownButtonFormField<String>(
      dropdownColor: Colors.black,
      value: gender,
      items: ['Select Gender', 'Male', 'Female', 'Other'].map((String gender) {
        return DropdownMenuItem<String>(
          value: gender,
          child: Text(
            gender,
            style: const TextStyle(color: Colors.white),
          ),
        );
      }).toList(),
      onChanged: (String? newGender) {
        setState(() {
          gender = newGender!;
        });
      },
      decoration: const InputDecoration(
        labelText: 'Gender',
        labelStyle: TextStyle(color: Colors.grey),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
      ),
    );
  }
}
