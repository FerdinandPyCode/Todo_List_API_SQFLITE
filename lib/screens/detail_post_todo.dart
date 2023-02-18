// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:todo_app/data/models/comment.dart';
// import 'package:todo_app/data/models/todo.dart';
// import 'package:todo_app/data/services/comments_service.dart';

// class DetailPostScreen extends StatefulWidget {
//   const DetailPostScreen({Key? key, required this.post}) : super(key: key);

//   final Post post;

//   @override
//   State<DetailPostScreen> createState() => _DetailPostScreenState();
// }

// class _DetailPostScreenState extends State<DetailPostScreen> {
//   final contentController = TextEditingController();

//   List<Comment> _comments = [];

//   final formKey = GlobalKey<FormState>();

//   bool isLoading = false;

//   _createComment(content) async {
//     setState(() {
//       isLoading = true;
//     });
//     try {
//       var result = await CommentService.create(
//           {'content': content, 'post_id': widget.post.id});
//       contentController.text = "";
//       await _loadComments();
//       Fluttertoast.showToast(msg: "Commentaire ajouté avec succès");
//     } on DioError catch (e) {
//       Map<String, dynamic> error = e.response?.data;
//       if (error.containsKey('message')) {
//         Fluttertoast.showToast(msg: error['message']);
//       } else {
//         Fluttertoast.showToast(
//             msg: "Une erreur est survenue veuillez rééssayer");
//       }
//       print(e.response);
//     } finally {
//       setState(() {
//         isLoading = false;
//       });
//     }
//   }

//   _loadComments() async {
//     try {
//       _comments = await CommentService.fetch(
//           queryParameters: {'post_id': widget.post.id});
//     } on DioError catch (e) {
//       Map<String, dynamic> error = e.response?.data;
//       if (error.containsKey('message')) {
//         Fluttertoast.showToast(msg: error['message']);
//       } else {
//         Fluttertoast.showToast(
//             msg: "Une erreur est survenue veuillez rééssayer");
//       }
//       print(e.response);
//     } finally {
//       setState(() {});
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     _loadComments();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.post.title!),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(10),
//         child: Column(
//           children: [
//             Text(
//               widget.post.title!,
//               textAlign: TextAlign.center,
//               style: const TextStyle(
//                   color: Colors.green,
//                   fontWeight: FontWeight.bold,
//                   fontSize: 20),
//             ),
//             const SizedBox(
//               height: 30.0,
//             ),
//             Text(
//               widget.post.content!,
//               textAlign: TextAlign.justify,
//               style: const TextStyle(fontSize: 17.0, color: Colors.black),
//             ),
//             const SizedBox(
//               height: 15.0,
//             ),
//             Form(
//                 key: formKey,
//                 child: Column(
//                   children: [
//                     TextFormField(
//                       controller: contentController,
//                       minLines: 3,
//                       maxLines: 5,
//                       keyboardType: TextInputType.text,
//                       decoration: const InputDecoration(
//                         labelText: "Ajouter un commentaire",
//                       ),
//                       validator: (value) {
//                         return value == null || value == ""
//                             ? "Ce champs est obligatoire"
//                             : null;
//                       },
//                     ),
//                     const SizedBox(height: 15),
//                     Align(
//                       alignment: Alignment.centerRight,
//                       child: ElevatedButton(
//                         onPressed: () async {
//                           if (formKey.currentState!.validate()) {
//                             await _createComment(contentController.text);
//                           }
//                         },
//                         child: isLoading
//                             ? const SizedBox(
//                                 height: 20,
//                                 width: 20,
//                                 child: CircularProgressIndicator(
//                                   color: Colors.white,
//                                   strokeWidth: 3,
//                                 ))
//                             : const Text("Ajouter"),
//                       ),
//                     )
//                   ],
//                 )),
//             const SizedBox(
//               height: 20.0,
//             ),
//             const Align(
//                 alignment: Alignment.centerLeft,
//                 child: Text(
//                   "Commentaires",
//                   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
//                 )),
//             Flexible(
//               child: ListView.builder(
//                   itemCount: _comments.length,
//                   itemBuilder: (context, index) {
//                     return Card(
//                       child: Padding(
//                         padding: const EdgeInsets.all(10),
//                         child: Column(
//                           children: [
//                             Align(
//                                 alignment: Alignment.centerLeft,
//                                 child: Text(
//                                   _comments[index].content!,
//                                   style: const TextStyle(fontSize: 16),
//                                 )),
//                             const SizedBox(
//                               height: 10,
//                             ),
//                             Align(
//                                 alignment: Alignment.centerRight,
//                                 child: Text(
//                                   "Par ${_comments[index].user!.username!} le ${_comments[index].createdAt!.toString().substring(0, 11)} à ${_comments[index].createdAt!.toString().substring(11, 16)}",
//                                   style: const TextStyle(
//                                       fontSize: 13,
//                                       fontStyle: FontStyle.italic
//                                     ),
//                                 )),
//                           ],
//                         ),
//                       ),
//                     );
//                   }),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
