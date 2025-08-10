// import 'package:flutter/material.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';
// import 'package:file_picker/file_picker.dart';

// class FileUploadScreen extends StatefulWidget {
//   const FileUploadScreen({super.key});

//   @override
//   State<FileUploadScreen> createState() => _FileUploadScreenState();
// }

// class _FileUploadScreenState extends State<FileUploadScreen> {
//   List<String> fileUrls = [];
//   bool isLoading = false;

//   Future<void> uploadFile() async {
//     try {
//       setState(() => isLoading = true);

//       final result = await FilePicker.platform.pickFiles(
//         type: FileType.image,
//         withData: true,
//       );

//       if (result == null) {
//         setState(() => isLoading = false);
//         return;
//       }

//       final file = result.files.first;
//       final fileBytes = file.bytes;
//       final fileName = sanitizeFileName(file.name);

//       if (fileBytes == null) {
//         setState(() => isLoading = false);
//         throw Exception('Selected file has no bytes');
//       }

//       final storage = Supabase.instance.client.storage;
//       final bucket = storage.from('user-uploads');

//       final path = 'uploads/$fileName';
//       await bucket.uploadBinary(
//         path,
//         fileBytes,
//         fileOptions: const FileOptions(upsert: true),
//       );

//       await fetchFileList();
//     } catch (e, stack) {
//       print('Upload error: $e');
//       print(stack);
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Upload failed: $e')),
//       );
//     } finally {
//       setState(() => isLoading = false);
//     }
//   }

//   Future<void> fetchFileList() async {
//     final storage = Supabase.instance.client.storage.from('user-uploads');
//     final result = await storage.list(path: 'uploads');

//     final urls = result
//         .map((item) => storage.getPublicUrl('uploads/${item.name}'))
//         .toList();

//     setState(() {
//       fileUrls = urls;
//     });
//   }

//   @override
//   void initState() {
//     super.initState();
//     fetchFileList();
//   }

//   String sanitizeFileName(String originalName) {
//     final timestamp = DateTime.now().millisecondsSinceEpoch;
//     final extension = originalName.split('.').last;
//     return 'file_$timestamp.$extension';
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Supabase File Upload'),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.refresh),
//             onPressed: fetchFileList,
//             tooltip: 'Reload',
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             ElevatedButton(
//               onPressed: isLoading ? null : uploadFile,
//               child: isLoading
//                   ? const CircularProgressIndicator()
//                   : const Text('Pick & Upload File'),
//             ),
//             const SizedBox(height: 20),
//             if (fileUrls.isNotEmpty)
//               Expanded(
//                 child: ListView.builder(
//                   itemCount: fileUrls.length,
//                   itemBuilder: (context, index) {
//                     final url = fileUrls[index];
//                     return Card(
//                       margin: const EdgeInsets.symmetric(vertical: 8),
//                       child: ListTile(
//                         title: Image.network(
//                           url,
//                           height: 150,
//                           fit: BoxFit.cover,
//                           errorBuilder: (_, __, ___) => const Text('Preview failed'),
//                         ),
//                         subtitle: Text(url),
//                       ),
//                     );
//                   },
//                 ),
//               )
//             else
//               const Text('No files uploaded yet.'),
//           ],
//         ),
//       ),
//     );
//   }
// }

// lib/screens/file_upload_screen.dart

// import 'package:flutter/material.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:path/path.dart' as p;

// class FileUploadScreen extends StatefulWidget {
//   const FileUploadScreen({Key? key}) : super(key: key);

//   @override
//   State<FileUploadScreen> createState() => _FileUploadScreenState();
// }

// class _FileUploadScreenState extends State<FileUploadScreen> {
//   List<String> fileUrls = [];
//   bool isLoading = false;

//   Future<void> uploadFile() async {
//     try {
//       setState(() => isLoading = true);

//       final result = await FilePicker.platform.pickFiles(
//         type: FileType.image,
//         withData: true,
//       );

//       if (result == null) {
//         setState(() => isLoading = false);
//         return;
//       }

//       final file = result.files.first;
//       final fileBytes = file.bytes;
//       final fileName = sanitizeFileName(file.name);

//       if (fileBytes == null) {
//         setState(() => isLoading = false);
//         throw Exception('Selected file has no bytes');
//       }

//       final storage = Supabase.instance.client.storage;
//       final bucket = storage.from('user-uploads');

//       final path = 'uploads/$fileName';
//       await bucket.uploadBinary(
//         path,
//         fileBytes,
//         fileOptions: const FileOptions(upsert: true),
//       );

//       await fetchFileList();
//     } catch (e, stack) {
//       print('Upload error: $e');
//       print(stack);
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Upload failed: $e')),
//       );
//     } finally {
//       setState(() => isLoading = false);
//     }
//   }

//   Future<void> deleteFile(String fileUrl) async {
//     final storage = Supabase.instance.client.storage.from('user-uploads');
//     final fileName = p.basename(Uri.parse(fileUrl).path);
//     final path = 'uploads/$fileName';

//     try {
//       await storage.remove([path]);
//       await fetchFileList();
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('File deleted successfully')),
//       );
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Delete failed: $e')),
//       );
//     }
//   }

//   Future<void> fetchFileList() async {
//     final storage = Supabase.instance.client.storage.from('user-uploads');
//     final result = await storage.list(path: 'uploads');

//     final urls = result
//         .map((item) => storage.getPublicUrl('uploads/${item.name}'))
//         .toList();

//     setState(() {
//       fileUrls = urls;
//     });
//   }

//   @override
//   void initState() {
//     super.initState();
//     fetchFileList();
//   }

//   String sanitizeFileName(String originalName) {
//     final timestamp = DateTime.now().millisecondsSinceEpoch;
//     final extension = originalName.split('.').last;
//     return 'file_$timestamp.$extension';
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Supabase File Upload'),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.refresh),
//             onPressed: fetchFileList,
//             tooltip: 'Reload',
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             ElevatedButton(
//               onPressed: isLoading ? null : uploadFile,
//               child: isLoading
//                   ? const CircularProgressIndicator()
//                   : const Text('Pick & Upload File'),
//             ),
//             const SizedBox(height: 20),
//             if (fileUrls.isNotEmpty)
//               Expanded(
//                 child: ListView.builder(
//                   itemCount: fileUrls.length,
//                   itemBuilder: (context, index) {
//                     final url = fileUrls[index];
//                     return Card(
//                       margin: const EdgeInsets.symmetric(vertical: 8),
//                       child: Column(
//                         children: [
//                           ListTile(
//                             title: Image.network(
//                               url,
//                               height: 150,
//                               fit: BoxFit.cover,
//                               errorBuilder: (_, __, ___) => const Text('Preview failed'),
//                             ),
//                             subtitle: Text(url),
//                           ),
//                           Align(
//                             alignment: Alignment.centerRight,
//                             child: TextButton.icon(
//                               onPressed: () => deleteFile(url),
//                               icon: const Icon(Icons.delete, color: Colors.red),
//                               label: const Text('Delete', style: TextStyle(color: Colors.red)),
//                             ),
//                           )
//                         ],
//                       ),
//                     );
//                   },
//                 ),
//               )
//             else
//               const Text('No files uploaded yet.'),
//           ],
//         ),
//       ),
//     );
//   }
// }

///////////////////////////////////////////////////
// lib/screens/file_upload_screen.dart

// import 'package:flutter/material.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:path/path.dart' as p;
// import 'package:url_launcher/url_launcher.dart';

// class FileUploadScreen extends StatefulWidget {
//   const FileUploadScreen({Key? key}) : super(key: key);

//   @override
//   State<FileUploadScreen> createState() => _FileUploadScreenState();
// }

// class _FileUploadScreenState extends State<FileUploadScreen> {
//   List<String> fileUrls = [];
//   bool isLoading = false;

//   Future<void> uploadFile() async {
//     try {
//       setState(() => isLoading = true);

//       final result = await FilePicker.platform.pickFiles(
//         type: FileType.custom,
//         allowedExtensions: ['pdf', 'doc', 'docx', 'xls', 'xlsx', 'txt', 'png', 'jpg', 'jpeg'],
//         withData: true,
//       );

//       if (result == null) {
//         setState(() => isLoading = false);
//         return;
//       }

//       final file = result.files.first;
//       final fileBytes = file.bytes;
//       final fileName = sanitizeFileName(file.name);

//       if (fileBytes == null) {
//         setState(() => isLoading = false);
//         throw Exception('Selected file has no bytes');
//       }

//       final storage = Supabase.instance.client.storage;
//       final bucket = storage.from('user-uploads');

//       final path = 'uploads/$fileName';
//      final response =  await bucket.uploadBinary(
//         path,
//         fileBytes,
//         fileOptions: const FileOptions(upsert: true),
//       );
// print('Supabase base URL: ${response}');

//       await fetchFileList();
//     } catch (e, stack) {
//       print('Upload error: $e');
//       print(stack);
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Upload failed: $e')),
//       );
//     } finally {
//       setState(() => isLoading = false);
//     }
//   }

//   Future<void> deleteFile(String fileUrl) async {
//     final storage = Supabase.instance.client.storage.from('user-uploads');
//     final fileName = p.basename(Uri.parse(fileUrl).path);
//     final path = 'uploads/$fileName';

//     try {
//       await storage.remove([path]);
//       await fetchFileList();
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('File deleted successfully')),
//       );
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Delete failed: $e')),
//       );
//     }
//   }

//   Future<void> fetchFileList() async {
//     final storage = Supabase.instance.client.storage.from('user-uploads');
//     final result = await storage.list(path: 'uploads');

//     final urls = result
//         .map((item) => storage.getPublicUrl('uploads/${item.name}'))
//         .toList();

//     setState(() {
//       fileUrls = urls;
//     });
//   }

//   @override
//   void initState() {
//     super.initState();
//     fetchFileList();
//   }

//   String sanitizeFileName(String originalName) {
//     final timestamp = DateTime.now().millisecondsSinceEpoch;
//     final extension = originalName.split('.').last;
//     return 'file_$timestamp.$extension';
//   }

//   Widget getFileIcon(String url) {
//     final ext = p.extension(url).toLowerCase();
//     if (ext.contains('pdf')) return const Icon(Icons.picture_as_pdf, color: Colors.red);
//     if (ext.contains('doc')) return const Icon(Icons.description, color: Colors.blue);
//     if (ext.contains('xls')) return const Icon(Icons.table_chart, color: Colors.green);
//     if (ext.contains('jpg') || ext.contains('jpeg') || ext.contains('png')) {
//       return Image.network(url, height: 50, width: 50, fit: BoxFit.cover);
//     }
//     return const Icon(Icons.insert_drive_file);
//   }

//   void openFileInBrowser(String url) async {
//     final uri = Uri.parse(url);
//     if (await canLaunchUrl(uri)) {
//       await launchUrl(uri, mode: LaunchMode.externalApplication);
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Could not open file URL')),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Supabase File Upload'),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.refresh),
//             onPressed: fetchFileList,
//             tooltip: 'Reload',
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             ElevatedButton(
//               onPressed: isLoading ? null : uploadFile,
//               child: isLoading
//                   ? const CircularProgressIndicator()
//                   : const Text('Pick & Upload File'),
//             ),
//             const SizedBox(height: 20),
//             if (fileUrls.isNotEmpty)
//               Expanded(
//                 child: ListView.builder(
//                   itemCount: fileUrls.length,
//                   itemBuilder: (context, index) {
//                     final url = fileUrls[index];
//                     return Card(
//                       margin: const EdgeInsets.symmetric(vertical: 8),
//                       child: Column(
//                         children: [
//                           ListTile(
//                             leading: getFileIcon(url),
//                             title: Text(p.basename(url)),
//                             subtitle: Text(url),
//                             trailing: IconButton(
//                               icon: const Icon(Icons.download),
//                               onPressed: () => openFileInBrowser(url),
//                             ),
//                           ),
//                           Align(
//                             alignment: Alignment.centerRight,
//                             child: TextButton.icon(
//                               onPressed: () => deleteFile(url),
//                               icon: const Icon(Icons.delete, color: Colors.red),
//                               label: const Text('Delete', style: TextStyle(color: Colors.red)),
//                             ),
//                           )
//                         ],
//                       ),
//                     );
//                   },
//                 ),
//               )
//             else
//               const Text('No files uploaded yet.'),
//           ],
//         ),
//       ),
//     );
//   }
// }

///////////////////////////////////////////////

// lib/screens/file_upload_screen.dart

// import 'package:flutter/material.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:path/path.dart' as p;
// import 'package:url_launcher/url_launcher.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class FileUploadScreen extends StatefulWidget {
//   const FileUploadScreen({Key? key}) : super(key: key);

//   @override
//   State<FileUploadScreen> createState() => _FileUploadScreenState();
// }

// class _FileUploadScreenState extends State<FileUploadScreen> {
//   List<String> fileUrls = [];
//   bool isLoading = false;

//   Future<void> uploadFile() async {
//     try {
//       setState(() => isLoading = true);

//       final result = await FilePicker.platform.pickFiles(
//         type: FileType.custom,
//         allowedExtensions: [
//           'pdf',
//           'doc',
//           'docx',
//           'xls',
//           'xlsx',
//           'txt',
//           'png',
//           'jpg',
//           'jpeg'
//         ],
//         withData: true,
//       );

//       if (result == null) {
//         setState(() => isLoading = false);
//         return;
//       }

//       final file = result.files.first;
//       final fileBytes = file.bytes;
//       final fileName = sanitizeFileName(file.name);

//       if (fileBytes == null) {
//         setState(() => isLoading = false);
//         throw Exception('Selected file has no bytes');
//       }

//       final storage = Supabase.instance.client.storage;
//       final bucket = storage.from('user-uploads');

//       final path = 'uploads/$fileName';
//       await bucket.uploadBinary(
//         path,
//         fileBytes,
//         fileOptions: const FileOptions(upsert: true),
//       );

//       final fileUrl = bucket.getPublicUrl(path);
//       await FirebaseFirestore.instance.collection('uploaded_files').add({
//         'file_name': fileName,
//         'url': fileUrl,
//         'uploaded_at': FieldValue.serverTimestamp(),
//       });

//       await fetchFileList();
//     } catch (e, stack) {
//       print('Upload error: $e');
//       print(stack);
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Upload failed: $e')),
//       );
//     } finally {
//       setState(() => isLoading = false);
//     }
//   }

//   Future<void> deleteFile(String fileUrl) async {
//     final storage = Supabase.instance.client.storage.from('user-uploads');
//     final fileName = p.basename(Uri.parse(fileUrl).path);
//     final path = 'uploads/$fileName';

//     try {
//       await storage.remove([path]);
//       await fetchFileList();
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('File deleted successfully')),
//       );
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Delete failed: $e')),
//       );
//     }
//   }

//   Future<void> fetchFileList() async {
//     // final storage = Supabase.instance.client.storage.from('user-uploads');
//     // final result = await storage.list(path: 'uploads');

//     // final urls = result
//     //     .map((item) => storage.getPublicUrl('uploads/${item.name}'))
//     //     .toList();
//     FirebaseFirestore.instance
//         .collection('uploaded_files')
//         .get()
//         .then((snapshot) {
//       fileUrls = snapshot.docs.map((doc) => doc['url'] as String).toList();
//     });
//     print('Fetched file URLs: $fileUrls');
//     setState(() {
//       // fileUrls = urls;
//     });
//   }

//   @override
//   void initState() {
//     super.initState();
//     fetchFileList();
//   }

//   String sanitizeFileName(String originalName) {
//     final timestamp = DateTime.now().millisecondsSinceEpoch;
//     final extension = originalName.split('.').last;
//     return 'file_$timestamp.$extension';
//   }

//   Widget getFileIcon(String url) {
//     final ext = p.extension(url).toLowerCase();
//     if (ext.contains('pdf'))
//       return const Icon(Icons.picture_as_pdf, color: Colors.red);
//     if (ext.contains('doc'))
//       return const Icon(Icons.description, color: Colors.blue);
//     if (ext.contains('xls'))
//       return const Icon(Icons.table_chart, color: Colors.green);
//     if (ext.contains('jpg') || ext.contains('jpeg') || ext.contains('png')) {
//       return Image.network(url, height: 50, width: 50, fit: BoxFit.cover);
//     }
//     return const Icon(Icons.insert_drive_file);
//   }

//   void openFileInBrowser(String url) async {
//     final uri = Uri.parse(url);
//     if (await canLaunchUrl(uri)) {
//       await launchUrl(uri, mode: LaunchMode.externalApplication);
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Could not open file URL')),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Supabase File Upload'),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.refresh),
//             onPressed: fetchFileList,
//             tooltip: 'Reload',
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             ElevatedButton(
//               onPressed: isLoading ? null : uploadFile,
//               child: isLoading
//                   ? const CircularProgressIndicator()
//                   : const Text('Pick & Upload File'),
//             ),
//             const SizedBox(height: 20),
//             if (fileUrls.isNotEmpty)
//               Expanded(
//                 child: ListView.builder(
//                   itemCount: fileUrls.length,
//                   itemBuilder: (context, index) {
//                     final url = fileUrls[index];
//                     return Card(
//                       margin: const EdgeInsets.symmetric(vertical: 8),
//                       child: Column(
//                         children: [
//                           ListTile(
//                             leading: getFileIcon(url),
//                             title: Text(p.basename(url)),
//                             subtitle: Text(url),
//                             trailing: IconButton(
//                               icon: const Icon(Icons.download),
//                               onPressed: () => openFileInBrowser(url),
//                             ),
//                           ),
//                           Align(
//                             alignment: Alignment.centerRight,
//                             child: TextButton.icon(
//                               onPressed: () => deleteFile(url),
//                               icon: const Icon(Icons.delete, color: Colors.red),
//                               label: const Text('Delete',
//                                   style: TextStyle(color: Colors.red)),
//                             ),
//                           )
//                         ],
//                       ),
//                     );
//                   },
//                 ),
//               )
//             else
//               const Text('No files uploaded yet.'),
//           ],
//         ),
//       ),
//     );
//   }
// }

// lib/screens/file_upload_screen.dart

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart' as p;
import 'package:url_launcher/url_launcher.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FileUploadScreen extends StatefulWidget {
  const FileUploadScreen({super.key});

  @override
  State<FileUploadScreen> createState() => _FileUploadScreenState();
}

class _FileUploadScreenState extends State<FileUploadScreen> {
  List<QueryDocumentSnapshot> firebaseFiles = [];
  bool isLoading = false;

  Future<void> uploadFile() async {
    try {
      setState(() => isLoading = true);

      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'doc', 'docx', 'xls', 'xlsx', 'txt', 'png', 'jpg', 'jpeg'],
        withData: true,
      );

      if (result == null) {
        setState(() => isLoading = false);
        return;
      }

      final file = result.files.first;
      final fileBytes = file.bytes;
      final fileName = sanitizeFileName(file.name);

      if (fileBytes == null) {
        setState(() => isLoading = false);
        throw Exception('Selected file has no bytes');
      }

      final storage = Supabase.instance.client.storage;
      final bucket = storage.from('user-uploads');

      final path = 'uploads/$fileName';
      await bucket.uploadBinary(
        path,
        fileBytes,
        fileOptions: const FileOptions(upsert: true),
      );

      final fileUrl = bucket.getPublicUrl(path);
      await FirebaseFirestore.instance.collection('uploaded_files').add({
        'file_name': fileName,
        'url': fileUrl,
        'uploaded_at': FieldValue.serverTimestamp(),
      });

      await fetchFileList();
    } catch (e, stack) {
      print('Upload error: $e');
      print(stack);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Upload failed: $e')),
      );
    } finally {
      setState(() => isLoading = false);
    }
  }

  Future<void> deleteFile(String fileUrl, String docId) async {
    final storage = Supabase.instance.client.storage.from('user-uploads');
    final fileName = p.basename(Uri.parse(fileUrl).path);
    final path = 'uploads/$fileName';

    try {
      await storage.remove([path]);
      await FirebaseFirestore.instance.collection('uploaded_files').doc(docId).delete();
      await fetchFileList();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('File deleted successfully')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Delete failed: $e')),
      );
    }
  }

  Future<void> fetchFileList() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('uploaded_files')
        .orderBy('uploaded_at', descending: true)
        .get();

    setState(() {
      firebaseFiles = snapshot.docs;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchFileList();
  }

  String sanitizeFileName(String originalName) {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final extension = originalName.split('.').last;
    return 'file_$timestamp.$extension';
  }

  Widget getFileIcon(String url) {
    final ext = p.extension(url).toLowerCase();
    if (ext.contains('pdf')) return const Icon(Icons.picture_as_pdf, color: Colors.red);
    if (ext.contains('doc')) return const Icon(Icons.description, color: Colors.blue);
    if (ext.contains('xls')) return const Icon(Icons.table_chart, color: Colors.green);
    if (ext.contains('jpg') || ext.contains('jpeg') || ext.contains('png')) {
      return Image.network(url, height: 50, width: 50, fit: BoxFit.cover);
    }
    return const Icon(Icons.insert_drive_file);
  }

  void openFileInBrowser(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not open file URL')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Supabase File Upload'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: fetchFileList,
            tooltip: 'Reload',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: isLoading ? null : uploadFile,
              child: isLoading
                  ? const CircularProgressIndicator()
                  : const Text('Pick & Upload File'),
            ),
            const SizedBox(height: 20),
            if (firebaseFiles.isNotEmpty)
              Expanded(
                child: ListView.builder(
                  itemCount: firebaseFiles.length,
                  itemBuilder: (context, index) {
                    final doc = firebaseFiles[index];
                    final url = doc['url'] as String;
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      child: Column(
                        children: [
                          ListTile(
                            leading: getFileIcon(url),
                            title: Text(doc['file_name']),
                            subtitle: Text(url),
                            trailing: IconButton(
                              icon: const Icon(Icons.download),
                              onPressed: () => openFileInBrowser(url),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton.icon(
                              onPressed: () => deleteFile(url, doc.id),
                              icon: const Icon(Icons.delete, color: Colors.red),
                              label: const Text('Delete', style: TextStyle(color: Colors.red)),
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ),
              )
            else
              const Text('No files uploaded yet.'),
          ],
        ),
      ),
    );
  }
}
