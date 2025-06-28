import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:multi/data/router_names.dart';
import 'package:multi/logic/cubit/order_list_cubit.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  @override
  void initState() {
    super.initState();
    context.read<OrderListCubit>().fetchOrders();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("My Orders")),
      body: BlocBuilder<OrderListCubit, OrderListState>(
        builder: (context, state) {
          if (state is OrderListLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is OrderListLoaded) {
            final orders = state.orders;
            if (orders.isEmpty) {
              return const Center(child: Text("No orders found."));
            }
            return ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: orders.length,
              itemBuilder: (context, index) {
                final order = orders[index];
                return Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  elevation: 2,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(12),
                    title: Text(
                      "Order #${order.orderCode}",
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 4),
                        Text("Total: \$${order.totalPrice}", style: const TextStyle(fontSize: 14)),
                        Text("Status: ${order.orderStatus.name}", style: const TextStyle(fontSize: 14)),
                        Text("Payment: ${order.paymentMethod.name} (${order.paymentStatus.name})",
                            style: const TextStyle(fontSize: 14)),
                        Text("Placed on: ${DateFormat.yMMMEd().format(DateTime.parse(order.createdAt))}",
                            style: const TextStyle(fontSize: 13, color: Colors.grey)),
                      ],
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 18),
                    onTap: () {

                      Navigator.pushNamed(
                        context,
                        RouteNames.orderDetailsScreen,
                        arguments: order,
                      );
                    },
                  ),
                );
              },
            );
          } else if (state is OrderListError) {
            return Center(child: Text(state.message));
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
