import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi/constants/app_constants.dart';
import 'package:multi/data/models/orders/order_model.dart';
import 'package:multi/logic/cubit/order_details_cubit.dart';
import 'package:multi/presentation/widgets/custom_images.dart';

class OrderDetailsScreen extends StatefulWidget {
  final OrderModel order;

  const OrderDetailsScreen({super.key, required this.order});

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<OrderDetailsCubit>().loadOrderDetails(widget.order.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Order Details")),
      body: BlocBuilder<OrderDetailsCubit, OrderDetailsState>(
        builder: (context, state) {
          if (state is OrderDetailsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is OrderDetailsLoaded) {
            final order = state.order;
            final item = order.storeItem.item;
            final store = order.storeItem.store;

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: CustomImage(
                      path: 
                      AppConstants.itemsPath + item.thumbnail,
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 20),

                  Text(
                    item.name,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    item.description ?? "No description available",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),

                  const SizedBox(height: 24),

                  _buildCard([
                    _buildTitle("Order Summary"),
                    _buildInfoText("Order ID: ${order.orderId}"),
                    _buildInfoText("Quantity: ${order.quantity}"),
                    _buildInfoText("Price: \$${order.price}"),
                    _buildInfoText("Subtotal: \$${order.subtotal}"),
                    _buildInfoText("Status: ${widget.order.orderStatus.name}"),
                    _buildInfoText("Payment: ${widget.order.paymentStatus.name}"),
                    _buildInfoText("Method: ${widget.order.paymentMethod.name}"),
                  ]),

                  const SizedBox(height: 24),

                  if (order.variation?.isNotEmpty ?? false) ...[
                    _buildTitle("Product Variations"),
                    Wrap(
                      spacing: 8,
                      children: order.variation!
                          .map((v) => Chip(
                                label: Text("${v.attributeName}: ${v.attributeValue}"),
                                backgroundColor: Colors.grey.shade100,
                              ))
                          .toList(),
                    ),
                  ],

                  const SizedBox(height: 24),

                  if (store != null)
                    _buildCard([
                      _buildTitle("Sold by"),
                      Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: CustomImage(
                              path: 
                              AppConstants.storeLogoUrl + store.logo!,
                              height: 50,
                              width: 50,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              store.name,
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ]),
                ],
              ),
            );
          } else if (state is OrderDetailsError) {
            return Center(child: Text(state.message));
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }

  Widget _buildTitle(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        text,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildInfoText(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Text(
        text,
        style: const TextStyle(fontSize: 16),
      ),
    );
  }

  Widget _buildCard(List<Widget> children) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: children),
      ),
    );
  }
}
