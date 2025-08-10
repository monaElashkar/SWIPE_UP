// // lib/services/paymob_service.dart

// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:webview_flutter/webview_flutter.dart';

// class PaymobService {
//   // Static values needed for API authentication and integration
//   static const String apiKey = 'YOUR_API_KEY';
//   static const String integrationId = 'YOUR_INTEGRATION_ID';
//   static const String iframeId = 'YOUR_IFRAME_ID';

//   static const String authUrl = 'https://accept.paymob.com/api/auth/tokens';
//   static const String orderUrl = 'https://accept.paymob.com/api/ecommerce/orders';
//   static const String paymentKeyUrl = 'https://accept.paymob.com/api/acceptance/payment_keys';

//   // Step 1: Get the authorization token using the API key
//   static Future<String?> getAuthToken() async {
//     final response = await http.post(
//       Uri.parse(authUrl),
//       headers: {'Content-Type': 'application/json'},
//       body: jsonEncode({'api_key': apiKey}),
//     );
//     if (response.statusCode == 201) {
//       return jsonDecode(response.body)['token'];
//     }
//     return null;
//   }

//   // Step 2: Create an order with amount and currency
//   static Future<int?> createOrder(String authToken, int amountCents) async {
//     final response = await http.post(
//       Uri.parse(orderUrl),
//       headers: {'Content-Type': 'application/json'},
//       body: jsonEncode({
//         "auth_token": authToken,
//         "delivery_needed": false,
//         "amount_cents": amountCents.toString(),
//         "currency": "EGP",
//         "items": []
//       }),
//     );
//     if (response.statusCode == 201) {
//       return jsonDecode(response.body)['id'];
//     }
//     return null;
//   }

//   // Step 3: Get the payment key using auth token and order ID
//   static Future<String?> getPaymentKey({
//     required String authToken,
//     required int orderId,
//     required int amountCents,
//     required Map<String, dynamic> billingData,
//   }) async {
//     final response = await http.post(
//       Uri.parse(paymentKeyUrl),
//       headers: {'Content-Type': 'application/json'},
//       body: jsonEncode({
//         "auth_token": authToken,
//         "amount_cents": amountCents.toString(),
//         "expiration": 3600,
//         "order_id": orderId,
//         "billing_data": billingData,
//         "currency": "EGP",
//         "integration_id": integrationId,
//       }),
//     );
//     if (response.statusCode == 201) {
//       return jsonDecode(response.body)['token'];
//     }
//     return null;
//   }

//   // Generate the payment iframe URL with the token
//   static String getPaymentUrl(String paymentToken) {
//     //https://accept.paymob.com/api/acceptance/iframes/944072?payment_token={payment_key_obtained_previously}
//     return 'https://accept.paymob.com/api/acceptance/iframes/$iframeId?payment_token=$paymentToken';
//   }
// }

// // WebView screen to load the Paymob payment URL
// class PaymobPaymentScreen extends StatelessWidget {
//   final String paymentToken;

//   const PaymobPaymentScreen({super.key, required this.paymentToken});

//   @override
//   Widget build(BuildContext context) {
//     final url = PaymobService.getPaymentUrl(paymentToken);
//     return Scaffold(
//       appBar: AppBar(title: const Text('Pay with Paymob')),
//       body: WebView(
//         initialUrl: url,
//         javascriptMode: JavascriptMode.unrestricted,
//       ),
//     );
//   }
// }

// // Example usage to trigger full payment flow
// Future<void> startPaymentFlow(BuildContext context) async {
//   // Get auth token
//   final token = await PaymobService.getAuthToken();
//   if (token == null) return;

//   // Create order with specific amount (in cents)
//   final orderId = await PaymobService.createOrder(token, 10000);
//   if (orderId == null) return;

//   // Customer billing information
//   final billing = {
//     "apartment": "803",
//     "email": "test@example.com",
//     "floor": "42",
//     "first_name": "Test",
//     "street": "Main St",
//     "building": "23",
//     "phone_number": "+201000000000",
//     "shipping_method": "PKG",
//     "postal_code": "12345",
//     "city": "Cairo",
//     "country": "EG",
//     "last_name": "User",
//     "state": "Cairo"
//   };

//   // Get payment token
//   final paymentToken = await PaymobService.getPaymentKey(
//     authToken: token,
//     orderId: orderId,
//     amountCents: 10000,
//     billingData: billing,
//   );

//   if (paymentToken == null) return;

//   // Navigate to WebView payment screen
//   Navigator.push(
//     context,
//     MaterialPageRoute(
//       builder: (_) => PaymobPaymentScreen(paymentToken: paymentToken),
//     ),
//   );
// }
