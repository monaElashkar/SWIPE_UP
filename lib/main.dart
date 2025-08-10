import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'file_upload_screen.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Supabase.initialize(
      url: 'https://qsgwdstyewokukbieuix.supabase.co',
      anonKey:
          "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InFzZ3dkc3R5ZXdva3VrYmlldWl4Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTM1MDAzNzgsImV4cCI6MjA2OTA3NjM3OH0.TKv8ywB5yWlVWIJcXbLgBXONcoQGfZ-c4YAwS61D_c0");
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
      // EasyLocalization(
      //     supportedLocales: [Locale('en'), Locale('ar')],
      //     path:
      //         'assets/translations', // <-- change the path of the translation files
      //     assetLoader: CodegenLoader(),
      //     fallbackLocale: Locale('en', 'US'),
      //     saveLocale: true,

      //     child:
      MyApp()
      // ),
      );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // localizationsDelegates: context.localizationDelegates,
      // supportedLocales: context.supportedLocales,
      // locale: context.locale,
      home: FileUploadScreen(),
      debugShowCheckedModeBanner: false,

      // BlocProvider(
      //   create: (_) => ProductCubit(ProductService())..fetchInitialProducts(),
      //   child: const ProductListScreen(),
      // ),
    );
  }
}





// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       routes: {},
//       onGenerateRoute: (settings) => AppRoute().generateRoute(settings),
//       home: Scaffold(
//           appBar: AppBar(
//             title: const Text('Swipe Up'),
//           ),
//           body: Column(
//             children: [
              
//               Center(
//                 child: InkWell(
//                   onTap: () {
//                     Navigator.pushNamed(context, RouteKey.onbourding);
//                   },
//                   child: const Text(
//                     'Go to Onboarding Screen',
//                     style: TextStyle(fontSize: 20),
//                   ),
//                 ),
//               ),
//             ],
//           )),
//     );
//   }
// }




// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: UploadImageToSupabase(),
//     );
//   }
// }

// class UploadImageToSupabase extends StatefulWidget {
//   const UploadImageToSupabase({super.key});

//   @override
//   State<UploadImageToSupabase> createState() => _UploadImageToSupabaseState();
// }

// class _UploadImageToSupabaseState extends State<UploadImageToSupabase> {
//   final picker = ImagePicker();
//   String? imageUrl;
//   bool isLoading = false;

//   Future<void> pickAndUploadImage() async {
//     final picked = await picker.pickImage(source: ImageSource.gallery);
//     if (picked == null) return;

//     setState(() => isLoading = true);

//     final file = File(picked.path);
//     final fileBytes = await file.readAsBytes();
//     final fileExt = p.extension(picked.path);
//     final fileName = 'uploads/${DateTime.now().millisecondsSinceEpoch}$fileExt';

//     final supabase = Supabase.instance.client;
//     final storage = supabase.storage.from('avatars');

//     try {
//       await storage.uploadBinary(
//         fileName,
//         fileBytes,
//         fileOptions: const FileOptions(upsert: true, contentType: 'image/png'),
//       );

//       final publicUrl = storage.getPublicUrl(fileName);
//       setState(() => imageUrl = publicUrl);
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Upload failed: $e')),
//       );
//     } finally {
//       setState(() => isLoading = false);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Upload to Supabase')),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             if (isLoading) const CircularProgressIndicator(),
//             if (imageUrl != null)
//               Padding(
//                 padding: const EdgeInsets.all(12.0),
//                 child: Image.network(imageUrl!, height: 200),
//               )
//             else if (!isLoading)
//               const Icon(Icons.image, size: 100),
//             const SizedBox(height: 16),
//             ElevatedButton(
//               onPressed: isLoading ? null : pickAndUploadImage,
//               child: const Text('Pick & Upload Image'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

