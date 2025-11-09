// import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart';
//
// class UsefulLinksTile extends StatefulWidget {
//   final List<Map<String, String>> initialLinks;
//   final void Function(List<Map<String, String>> updatedLinks)? onLinksChanged;
//
//   const UsefulLinksTile({
//     super.key,
//     this.initialLinks = const [],
//     this.onLinksChanged,
//   });
//
//   @override
//   State<UsefulLinksTile> createState() => _UsefulLinksTileState();
// }
//
// class _UsefulLinksTileState extends State<UsefulLinksTile> {
//   late List<Map<String, String>> _links;
//
//   @override
//   void initState() {
//     super.initState();
//     _links = List.from(widget.initialLinks);
//   }
//
//   void _addLink() async {
//     final nameController = TextEditingController();
//     final urlController = TextEditingController();
//
//     final result = await showDialog<bool>(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text('Dodaj nowy link'),
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             TextField(
//               controller: nameController,
//               decoration: const InputDecoration(labelText: 'Nazwa'),
//             ),
//             TextField(
//               controller: urlController,
//               decoration: const InputDecoration(labelText: 'Adres URL'),
//               keyboardType: TextInputType.url,
//             ),
//           ],
//         ),
//         actions: [
//           TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Anuluj')),
//           TextButton(onPressed: () => Navigator.pop(context, true), child: const Text('Zapisz')),
//         ],
//       ),
//     );
//
//     if (result == true) {
//       final name = nameController.text.trim();
//       final url = urlController.text.trim();
//       if (name.isNotEmpty && url.isNotEmpty) {
//         setState(() {
//           _links.add({'name': name, 'url': url});
//         });
//         widget.onLinksChanged?.call(_links);
//       }
//     }
//   }
//
//   void _deleteLink(int index) {
//     setState(() {
//       _links.removeAt(index);
//     });
//     widget.onLinksChanged?.call(_links);
//   }
//
//   void _openUrl(String url) async {
//     final uri = Uri.tryParse(url);
//     if (uri != null && await canLaunchUrl(uri)) {
//       await launchUrl(uri, mode: LaunchMode.externalApplication);
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Nieprawidłowy adres URL')),
//       );
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Row(
//           children: [
//             const Text(
//               'Przydatne linki',
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             const Spacer(),
//             IconButton(
//               onPressed: _addLink,
//               icon: const Icon(Icons.add),
//               tooltip: 'Dodaj link',
//             )
//           ],
//         ),
//         const SizedBox(height: 8),
//         ..._links.asMap().entries.map((entry) {
//           final index = entry.key;
//           final link = entry.value;
//           return Card(
//             child: ListTile(
//               title: Text(link['name'] ?? ''),
//               subtitle: Text(link['url'] ?? ''),
//               trailing: IconButton(
//                 icon: const Icon(Icons.delete),
//                 onPressed: () => _deleteLink(index),
//               ),
//               onTap: () => _openUrl(link['url'] ?? ''),
//             ),
//           );
//         }).toList(),
//       ],
//     );
//   }
// }
