import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../generated/key_loader.dart';
import '../cubit/product_cubit.dart';
import '../cubit/product_state.dart';
import 'package:easy_localization/easy_localization.dart' as tr;
import 'add_product_screen.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200) {
        context.read<ProductCubit>().fetchMoreProducts();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        appBar: AppBar(title: const Text("Products")),
        body: BlocBuilder<ProductCubit, ProductState>(
          builder: (context, state) {
            if (state is ProductLoading && state is! ProductLoaded) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ProductLoaded) {
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      controller: _scrollController,
                      itemCount: state.products.length + (state.hasMore ? 1 : 0),
                      itemBuilder: (context, index) {
                        if (index == state.products.length) {
                          return const Padding(
                            padding: EdgeInsets.all(16),
                            child: Center(child: CircularProgressIndicator()),
                          );
                        }
                        final product = state.products[index];
                        return ListTile(
                          leading: product.imageUrl != null
                              ? Image.network(product.imageUrl!, width: 50)
                              : null,
                          title: Text(product.name),
                          subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
                        );
                      },
                    ),
                  ),
                  if (state.hasMore) ...[
                    SizedBox(
                      height: 16,
                    ),
                    CircularProgressIndicator(),
                  ],
                  if (state.hasMore == false) ...[
                    SizedBox(
                      height: 16,
                    ),
                    Text(LocaleKeys.test.tr()),
                  ]
                ],
              );
            } else if (state is ProductError) {
              return Center(child: Text(state.message));
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            context.setLocale(const Locale('en'));
            context.locale;
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => BlocProvider.value(
                          value: context.read<ProductCubit>(),
                          child: const AddProductScreen(),
                        )));
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
