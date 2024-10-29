
// import 'dart:convert'; // Ensure this is imported

// Future<void> _submit() async {
//   try {
//     const String url = 'https://chitsoft.in/wapp/api/mobile3/login_user_api.php';

//     final String userId = useridcontroller.text;
//     final String userPassword = userpsdcontroller.text;

//     final response = await http.post(
//       Uri.parse(url),
//       headers: {
//         'Content-Type': 'application/json', // Specify JSON content type
//       },
//       body: jsonEncode({
//         'user': userId,
//         'password': userPassword,
//       }),
//     );

//     print(response.body);

//     if (response.statusCode == 200) {
//       final Map<String, dynamic> responseData = jsonDecode(response.body);
//       final errorMsg = responseData['error_msg'] ?? 'Unknown error';
      
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text(errorMsg),
//         ),
//       );

//       // Navigate to CreatePasswordScreen on success
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => const CreatePasswordScreen(),
//         ),
//       );
//     } else {
//       final Map<String, dynamic> responseData = jsonDecode(response.body);
//       final errorMsg = responseData['error_msg'] ?? 'Unknown error';
      
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text(errorMsg),
//         ),
//       );
//     }
//   } catch (e) {
//     print(e);
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text('Error: $e'),
//       ),
//     );
//   }
// }
////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///
///
///
///-
// Future<void> _submit() async {
//   if (_formKey.currentState?.validate() == true) {
//     final String userId = useridcontroller.text;
//     final String userPassword = userpsdcontroller.text;

//     // Check if the userId and password are not empty
//     if (userId.isNotEmpty && userPassword.isNotEmpty) {
//       try {
//         const String url = 'https://chitsoft.in/wapp/api/mobile3/login_user_api.php';

//         final response = await http.post(
//           Uri.parse(url),
//           body: jsonEncode({
//             'user': userId,
//             'password': userPassword,
//           }),
//         );

//         if (response.statusCode == 200) {
//           final Map<String, dynamic> responseData = jsonDecode(response.body);
//           final errorMsg = responseData['error_msg'] ?? 'Unknown error';
          
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(
//               content: Text(errorMsg),
//             ),
//           );

//           // Clear input fields after a successful response
//           useridcontroller.clear();
//           userpsdcontroller.clear();

//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => PurchasedChitsScreen(),
//             ),
//           );
//         } else if (response.statusCode == 400) {
//           final Map<String, dynamic> responseData = jsonDecode(response.body);
//           final errorMsg = responseData['error_msg'] ?? 'Unknown error';
          
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(
//               content: Text(errorMsg),
//             ),
//           );
//         } else {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(
//               content: Text('Error: ${response.statusCode}'),
//             ),
//           );
//         }
//       } catch (e) {
//         print(e);
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('Error: $e'),
//           ),
//         );
//       }
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text('User ID and password cannot be empty'),
//         ),
//       );
//     }
//   } else {
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(
//         content: Text('Required Parameter Missing: user ID and password'),
//       ),
//     );
//   }
// }
