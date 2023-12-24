import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paypal_checkout/flutter_paypal_checkout.dart';
import 'package:google_fonts/google_fonts.dart';
import '../components/cart_card.dart';
import '../models/cart_list.dart';
import '../models/food.dart';
import '../theme/app_color.dart';
import '../MainPage.dart';
import '../API/MenuAPI.dart';

class Cart extends StatefulWidget with ChangeNotifier {
  final List<FoodData> _items = CartList.items;
  double _price = CartList.totalPrice;
  Cart({super.key});

  void add(FoodData item) {
    CartList.add(item);
    notifyListeners();
  }

  void delete(FoodData item) {
    CartList.delete(item);
    notifyListeners();
  }

  int get count {
    return _items.length;
  }

  double get totalPrice {
    return _price;
  }

  List<FoodData> get items {
    return _items;
  }

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  void update() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColorsLight.lightColor,
        appBar: AppBar(
          elevation: 0,
          title: Text("Shooping Cart",
              style: GoogleFonts.aladin(
                color: AppColorsLight.primaryColor,
                fontSize: 40,
              )),
          leading: IconButton(
            onPressed: () {
              update();
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back_ios,
                color: AppColorsLight.primaryColor),
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.transparent)),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: CartList.items.length,
                itemBuilder: (context, index) => CartCard(
                  food: CartList.items[index],
                  update: update,
                ),
              ),
            ),
            Stack(
              children: [
                Center(
                  child: InkWell(
                    onTap: () {
                      openCoupon(context);
                    },
                    child: Ink(
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColorsLight.primaryColor.shade300,
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              bottom: 15.0, top: 15.0, left: 15.0, right: 15.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.monetization_on_sharp,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "Coupons",
                                    style: GoogleFonts.alata(
                                      fontSize: 15,
                                    ),
                                  )
                                ],
                              ),
                              Icon(Icons.chevron_right)
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Center(
              child: Container(
                decoration: BoxDecoration(
                  color: AppColorsLight.primaryColor.shade300,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(15),
                    topLeft: Radius.circular(15),
                  ),
                ),
                width: MediaQuery.of(context).size.width * 0.9,
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 15.0, left: 15.0, right: 15.0, bottom: 8.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Subtotal:",
                            style: GoogleFonts.dmSerifDisplay(
                              fontSize: 20,
                            ),
                          ),
                          Text(
                            "${CartList.totalPrice.toStringAsFixed(2)}",
                            style: GoogleFonts.dmSerifDisplay(
                              fontSize: 20,
                              color: AppColorsLight.lightColor,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Delivery Fee:",
                            style: GoogleFonts.dmSerifDisplay(
                              fontSize: 20,
                            ),
                          ),
                          Text(
                            "Free!",
                            style: GoogleFonts.dmSerifDisplay(
                              fontSize: 20,
                              color: AppColorsLight.lightColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            color: AppColorsLight.primaryColor.shade200,
                            child: Container(
                              width: 80,
                              height: 80,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.location_on),
                                  SizedBox(height: 5),
                                  Text(
                                    "Location",
                                    style: GoogleFonts.dmSerifDisplay(
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              openPayment(context);
                            },
                            child: Ink(
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                color: AppColorsLight.primaryColor.shade200,
                                child: Container(
                                  width: 80,
                                  height: 80,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.payments_outlined),
                                      SizedBox(height: 5),
                                      Text(
                                        "Payment",
                                        style: GoogleFonts.dmSerifDisplay(
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        color: AppColorsLight.primaryColor.shade500,
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.6,
                          child: TextButton(
                            onPressed: () async {
                              if (paymentStatus == false) {
                                //print(FoodData.toItemCart(CartList.items));
                                if (CartList.items.isNotEmpty) {
                                  APIStatus status = await placeOrder(20, 20,
                                      FoodData.toItemCart(CartList.items));
                                  if (status.statusCode == 200 &&
                                      context.mounted) {
                                    CartList.items.clear();
                                  }
                                  if (context.mounted) {
                                    setState(() {});
                                    Navigator.pop(context);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            behavior: SnackBarBehavior.floating,
                                            showCloseIcon: true,
                                            duration:
                                                const Duration(seconds: 3),
                                            content: Text(status.message)));
                                  }
                                }

                                return;
                              }
                              if (selector == 0 && CartList.totalPrice != 0) {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      PaypalCheckout(
                                    sandboxMode: true,
                                    clientId:
                                        "AZDDFOVhWgqhO3iG_yu0pbfT_wV96i_VZMvL17A5dgUQw2xiVI2kC6Qz_MAZtcmzeDyt3wl8HBkf5WDK",
                                    secretKey:
                                        "EFiP_5IhzWUqbFCD7mt_P7hRYjn3aZCqENbX2-kIVQXwZNnhdh0zuFlZ170QD-792xfpZHOmyW3E5tpC",
                                    returnURL: "success.snippetcoder.com",
                                    cancelURL: "cancel.snippetcoder.com",
                                    transactions: [
                                      {
                                        "amount": {
                                          "total": CartList.totalPrice,
                                          "currency": "USD",
                                          "details": {
                                            "subtotal": CartList.totalPrice,
                                            "shipping": '0',
                                            "shipping_discount": 0
                                          }
                                        },
                                        "description":
                                            "The payment transaction description.",
                                        // "payment_options": {
                                        //   "allowed_payment_method":
                                        //       "INSTANT_FUNDING_SOURCE"
                                        // },
                                        "item_list": {
                                          "items": [
                                            {
                                              "name": "A demo product",
                                              "quantity": 1,
                                              "price": CartList.totalPrice,
                                              "currency": "USD"
                                            },
                                          ],

                                          // shipping address is not required though
                                          //   "shipping_address": {
                                          //     "recipient_name": "Raman Singh",
                                          //     "line1": "Delhi",
                                          //     "line2": "",
                                          //     "city": "Delhi",
                                          //     "country_code": "IN",
                                          //     "postal_code": "11001",
                                          //     "phone": "+00000000",
                                          //     "state": "Texas"
                                          //  },
                                        }
                                      }
                                    ],
                                    note:
                                        "Contact us for any questions on your order.",
                                    onSuccess: (Map params) async {
                                      setState(() {
                                        CartList.clear();
                                      });
                                      print("onSuccess: $params");
                                      Navigator.of(context).pop();
                                    },
                                    onError: (error) {
                                      print("onError: $error");
                                      Navigator.pop(context);
                                    },
                                    onCancel: () {
                                      print('cancelled:');
                                    },
                                  ),
                                ));
                              } else if (selector != 0) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  backgroundColor:
                                      AppColorsLight.secondaryColor.shade800,
                                  action: SnackBarAction(
                                    label: "OK",
                                    textColor: AppColorsLight.lightColor,
                                    onPressed: () {},
                                  ),
                                  content: Text("Paypal only",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                ));
                              } else {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  backgroundColor:
                                      AppColorsLight.secondaryColor.shade800,
                                  action: SnackBarAction(
                                    label: "OK",
                                    textColor: AppColorsLight.lightColor,
                                    onPressed: () {},
                                  ),
                                  content: Text("The Cart is Empty",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                ));
                              }
                            },
                            style: TextButton.styleFrom(
                              backgroundColor: AppColorsLight.primaryColor,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Check Out",
                                  style: GoogleFonts.dmSerifDisplay(
                                    fontSize: 20,
                                    color: AppColorsLight.lightColor,
                                  ),
                                ),
                                Icon(
                                  Icons.arrow_right_outlined,
                                  color: AppColorsLight.lightColor,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ));
  }

  int selector = 0;
  Future<void> openPayment(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(
              Icons.payments,
              color: AppColorsLight.primaryColor.shade800,
            ),
            SizedBox(width: 10),
            Text(
              "Payment",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 27,
                color: AppColorsLight.secondaryColor.shade800,
              ),
            ),
          ],
        ),
        content: Container(
          padding: EdgeInsets.all(5.0),
          height: 220,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        selector = 0;
                      });
                      Navigator.of(context).pop(); // Close the dialog
                    },
                    child: Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: (selector == 0)
                            ? AppColorsLight.primaryColor.shade200
                            : null,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: (selector == 0)
                            ? EdgeInsets.all(8.0)
                            : EdgeInsets.all(0),
                        child: Image.asset("Images/Payment/Paypal.png"),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        selector = 1;
                      });
                      Navigator.of(context).pop(); // Close the dialog
                    },
                    child: Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: (selector == 1)
                            ? AppColorsLight.primaryColor.shade200
                            : null,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: (selector == 1)
                            ? EdgeInsets.all(8.0)
                            : EdgeInsets.all(0),
                        child: Image.asset("Images/Payment/Visa.png"),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        selector = 2;
                      });
                      Navigator.of(context).pop(); // Close the dialog
                    },
                    child: Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: (selector == 2)
                            ? AppColorsLight.primaryColor.shade200
                            : null,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: (selector == 2)
                            ? EdgeInsets.all(8.0)
                            : EdgeInsets.all(0),
                        child: Image.asset("Images/Payment/Mastercard.png"),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        selector = 3;
                      });
                      Navigator.of(context).pop(); // Close the dialog
                    },
                    child: Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: (selector == 3)
                            ? AppColorsLight.primaryColor.shade200
                            : null,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: (selector == 3)
                            ? EdgeInsets.all(8.0)
                            : EdgeInsets.all(0),
                        child: Image.asset("Images/Payment/Bitcoin.png"),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              "Save",
              style: GoogleFonts.dmSerifDisplay(
                fontSize: 20,
                color: AppColorsLight.lightColor,
              ),
            ),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                AppColorsLight.primaryColor.shade800,
              ),
            ),
          ),
        ],
      ),
    );
  }

  TextEditingController? coupon = TextEditingController();
  Future<void> openCoupon(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColorsLight.secondaryColor.shade200,
        title: Row(
          children: [
            Icon(
              Icons.monetization_on_sharp,
              color: AppColorsLight.primaryColor.shade800,
            ),
            SizedBox(width: 10),
            Text(
              "Coupon",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 27,
                color: AppColorsLight.secondaryColor.shade800,
              ),
            ),
          ],
        ),
        content: Container(
            padding: EdgeInsets.all(5.0),
            child: TextField(
              controller: coupon,
              decoration: const InputDecoration(
                border: InputBorder.none,
                labelText: 'Enter The Coupon',
              ),
            )),
        actions: [
          TextButton(
            onPressed: () {
              if (coupon!.text != CartList.coupon) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  backgroundColor: AppColorsLight.secondaryColor.shade800,
                  action: SnackBarAction(
                    label: "OK",
                    textColor: AppColorsLight.lightColor,
                    onPressed: () {},
                  ),
                  content: Text("The coupon is incorrect",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ));
              } else if (CartList.totalPrice != CartList.oldTotalPrice ||
                  CartList.couponstate == true) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  backgroundColor: AppColorsLight.secondaryColor.shade800,
                  action: SnackBarAction(
                    label: "OK",
                    textColor: AppColorsLight.lightColor,
                    onPressed: () {},
                  ),
                  content: Text("You already used the coupon",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ));
              } else {
                CartList.updatePrice(10);
              }
              update();
              Navigator.of(context).pop();
            },
            child: Text(
              "Save",
              style: GoogleFonts.dmSerifDisplay(
                fontSize: 20,
                color: AppColorsLight.lightColor,
              ),
            ),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                AppColorsLight.primaryColor.shade800,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
