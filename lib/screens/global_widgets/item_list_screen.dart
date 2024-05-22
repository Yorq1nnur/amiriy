// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:my_utils/my_utils.dart';
// import '../../utils/colors/app_colors.dart';
// import '../routes.dart';
//
// class ItemsListScreen extends StatefulWidget {
//   const ItemsListScreen({super.key, required this.category});
//
//   final String category;
//
//   @override
//   State<ItemsListScreen> createState() => _ItemsListScreenState();
// }
//
// class _ItemsListScreenState extends State<ItemsListScreen> {
//   TextEditingController textEditingController = TextEditingController();
//   String search = '';
//   bool isSelect = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: AppColors.white,
//         title: Text(
//           widget.category,
//         ),
//         // actions: [
//         //   IconButton(
//         //     onPressed: () {
//         //       Navigator.pushNamed(context, RouteNames.cartScreen);
//         //     },
//         //     icon: const Icon(Icons.shopping_cart,
//         //
//         //     ),
//         //   ),
//         //   const SizedBox(width: 4),
//         //   IconButton(
//         //     onPressed: () {},
//         //     icon: const Icon(Icons.person),
//         //   ),
//         //   const SizedBox(width: 4),
//         //
//         //   const SizedBox(width: 4),
//         // ],
//         elevation: 0,
//       ),
//       body: BlocBuilder<ProductBloc, ProductState>(
//         builder: (context, state) {
//           if (state.status == ProductsStatus.loading) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (state.status == ProductsStatus.failure) {
//             return Center(
//               child: Text("Error${state.errorMessage}"),
//             );
//           } else if (state.products.isEmpty) {
//             return const Center(
//               child: Text("Malumot yo'q"),
//             );
//           } else {
//             return Column(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 15),
//                   child: GestureDetector(
//                     onTap: (){
//                       showSearch(
//                         context: context,
//                         delegate: ItemSearch(items:context.read<ProductBloc>().state.products), // Pass your list of items here
//                       );
//                     },
//                     child: SearchWidget(
//
//                       controller: textEditingController,
//                       voidCallback: (v) {},
//                     ),
//                   ),
//                 ),
//                 SingleChildScrollView(
//                   scrollDirection: Axis.horizontal,
//                   child: Row(
//                     children: [
//                       ItemCategory(title: "Tablets", voidCallback: () {}),
//                       ItemCategory(title: "Phones", voidCallback: () {}),
//                       ItemCategory(title: "Ipads", voidCallback: () {}),
//                       ItemCategory(title: "Ipod", voidCallback: () {}),
//                       ItemCategory(title: "Ipod", voidCallback: () {}),
//                     ],
//                   ),
//                 ),
//                 SortWidget(onListView: () {}, onGridView: () {}),
//                 const SizedBox(height: 10),
//                 Expanded(
//                   child: ListView(
//                     padding: const EdgeInsets.symmetric(horizontal: 15),
//                     children: [
//                       const SizedBox(height: 10),
//                       SingleChildScrollView(
//                         scrollDirection: Axis.horizontal,
//                         child: Row(
//                           children: [
//                             CompanyBtn(title: "Tablets", voidCallback: () {}),
//                             CompanyBtn(title: "Apple", voidCallback: () {}),
//                             CompanyBtn(title: "64GB", voidCallback: () {}),
//                             CompanyBtn(title: "Artel", voidCallback: () {}),
//                           ],
//                         ),
//                       ),
//                       const SizedBox(height: 10),
//                       ...List.generate(state.products.length, (index) {
//                         if (widget.category == "all" ||
//                             state.products[index].category
//                                 .toString()
//                                 .substring(9) ==
//                                 widget.category) {
//                           return GestureDetector(
//                             onTap: () {
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (context) => DetailScreen(
//                                       productModel: state.products[index]),
//                                 ),
//                               );
//                             },
//                             child: Container(
//                               margin: EdgeInsets.symmetric(vertical: 4.h),
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(6),
//                                 color: Colors.white,
//                                 border: Border.all(
//                                     width: 1, color: AppColors.c_DEE2E7),
//                               ),
//                               padding: EdgeInsets.symmetric(
//                                   vertical: 12.h, horizontal: 14.w),
//                               child: Row(
//                                 mainAxisAlignment: MainAxisAlignment.start,
//                                 children: [
//                                   Image.network(
//                                     state.products[index].image,
//                                     fit: BoxFit.cover,
//                                     height: 84.h,
//                                     width: 84.w,
//                                   ),
//                                   SizedBox(width: 15.w),
//                                   Column(
//                                     crossAxisAlignment:
//                                     CrossAxisAlignment.start,
//                                     children: [
//                                       Text(
//                                         state.products[index].name,
//                                         style: TextStyle(
//                                           fontSize: 16.sp,
//                                           color: AppColors.c_505050,
//                                           fontWeight: FontWeight.w400,
//                                         ),
//                                       ),
//                                       SizedBox(height: 3.h),
//                                       Text(
//                                         "\$${state.products[index].price.toString()}",
//                                         style: TextStyle(
//                                           fontSize: 16.sp,
//                                           color: AppColors.c_333333,
//                                           fontWeight: FontWeight.w600,
//                                         ),
//                                       ),
//                                       SizedBox(height: 3.h),
//                                       Row(
//                                         children: [
//                                           ...List.generate(
//                                             5,
//                                                 (index) => const Icon(Icons.star,
//                                                 color: Colors.amber),
//                                           ),
//                                           SizedBox(width: 8.w),
//                                           Text(
//                                             "7.5",
//                                             style: TextStyle(
//                                               fontSize: 13.sp,
//                                               color: Colors.amber,
//                                               fontWeight: FontWeight.w400,
//                                             ),
//                                           ),
//                                           SizedBox(width: 8.w),
//                                           const Icon(Icons.circle),
//                                           SizedBox(width: 8.w),
//                                           Text(
//                                             state.products[index].orders
//                                                 .toString(),
//                                             style: TextStyle(
//                                               fontSize: 13.sp,
//                                               color: AppColors.c_8B96A5,
//                                               fontWeight: FontWeight.w400,
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                       SizedBox(height: 3.h),
//                                       Text(
//                                         "Free Shipping",
//                                         style: TextStyle(
//                                           fontSize: 13.sp,
//                                           color: AppColors.black,
//                                           fontWeight: FontWeight.w600,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           );
//                         } else {
//                           return const SizedBox();
//                         }
//                       }),
//                     ],
//                   ),
//                 ),
//               ],
//             );
//           }
//         },
//       ),
//     );
//   }
// }
