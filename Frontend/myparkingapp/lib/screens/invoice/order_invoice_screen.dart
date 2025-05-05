import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:myparkingapp/app/locallization/app_localizations.dart';
import 'package:myparkingapp/bloc/invoice/invoice_bloc.dart';
import 'package:myparkingapp/bloc/invoice/invoice_event.dart';
import 'package:myparkingapp/bloc/invoice/invoice_state.dart';
import 'package:myparkingapp/components/app_dialog.dart';
import 'package:myparkingapp/data/response/user_response.dart';
import 'package:myparkingapp/main_screen.dart';
import 'package:myparkingapp/screens/invoice/QR_invoice_screen.dart';
import '../../constants.dart';

class OrderInvoiceScreen extends StatefulWidget {
  final UserResponse user;
  const OrderInvoiceScreen({super.key, required this.user});

  @override
  State<OrderInvoiceScreen> createState() => _OrderInvoiceScreenState();
}

class _OrderInvoiceScreenState extends State<OrderInvoiceScreen> {
  List<Invoice_QR> invoices = [];

  @override
  void initState() {
    super.initState();
    context.read<InvoiceBloc>().add(GetCurrentInvoiceEvent(widget.user.userID));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<InvoiceBloc, InvoiceState>(
      builder: (context, state) {
        if (state is InvoiceLoadingState) {
          return Center(
            child: LoadingAnimationWidget.staggeredDotsWave(
              color: Colors.greenAccent,
              size: 18,
            ),
          );
        } else if (state is GetCurrentInvoiceState) {
          invoices = state.invoices;
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              leading: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(100)),
                    ),
                    backgroundColor: Colors.black.withOpacity(0.5),
                    padding: EdgeInsets.zero,
                  ),
                  child: const Icon(Icons.close, color: Colors.white),
                  onPressed:
                      () => {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => MainScreen()),
                        ),
                      },
                ),
              ),
              title: Text(
                AppLocalizations.of(context).translate("QR Invoice"),
              ),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
                child: invoices.isNotEmpty ? Column(
                  children: [
                    const SizedBox(height: defaultPadding),
                    // List of cart items

                    ...List.generate(
                      invoices.length,
                      (index) => Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: defaultPadding / 2,
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> QRInvoiceScreen(request: invoices[index], user: widget.user,)));
                          },
                          child: Center(
                            child: Text(
                              "QR IN - OUT"
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ) :
                    Center(
                      child: Text(AppLocalizations.of(context).translate("You haven't booked a slot, booking now")),
                    )

              ),
            ),
          );
        }
        return Center(
          child: LoadingAnimationWidget.staggeredDotsWave(
            color: Colors.greenAccent,
            size: 18,
          ),
        );
      },
      listener: (context, state) {
        if (state is InvoiceErrorState) {
          AppDialog.showErrorEvent(context, AppLocalizations.of(context).translate(state.mess));
        }
      },
    );
  }
}


