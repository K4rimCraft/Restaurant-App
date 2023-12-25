import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import '../models/booking_table.dart';

Future<void> PdfGenerator(BuildContext context) async {
  final Uint8List imageData =
      (await rootBundle.load('assets/Receipt/Receipt.jpg'))
          .buffer
          .asUint8List();

  // final String qrData = 'Your QR code data here';
  // final QrImageView qrImage = QrImageView(
  //   data: qrData,
  //   version: QrVersions.auto,
  //   size: 300.0,
  // );

  final pdf = pw.Document();

  pdf.addPage(
    pw.Page(
      pageFormat: PdfPageFormat.roll80,
      build: (pw.Context context) {
        return pw.Center(
          child: pw.Stack(
            children: [
              pw.Image(pw.MemoryImage(imageData)),
              pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
                  children: [
                    pw.SizedBox(width: 80),
                    pw.Column(children: [
                      pw.SizedBox(height: 110),
                      pw.Text(BookingTable.name!,
                          style: pw.TextStyle(
                              fontWeight: pw.FontWeight.bold, fontSize: 8)),
                      pw.SizedBox(height: 13),
                      pw.Text(BookingTable.tableNumber.toString(),
                          style: pw.TextStyle(
                              fontWeight: pw.FontWeight.bold, fontSize: 8)),
                      pw.SizedBox(height: 14),
                      pw.Text(
                          "${BookingTable.dateTime!.day.toString()}-${BookingTable.dateTime!.month.toString()}-${BookingTable.dateTime!.year.toString()}",
                          style: pw.TextStyle(
                              fontWeight: pw.FontWeight.bold, fontSize: 8)),
                      pw.SizedBox(height: 14),
                      pw.Text(
                          "${BookingTable.pickedHour!.hour.toString()}:${BookingTable.pickedHour!.minute.toString()}",
                          style: pw.TextStyle(
                              fontWeight: pw.FontWeight.bold, fontSize: 8)),
                      pw.SizedBox(height: 14),
                      pw.Text(
                          "${(BookingTable.pickedHour!.hour + 1).toString()}:${BookingTable.pickedHour!.minute.toString()}",
                          style: pw.TextStyle(
                              fontWeight: pw.FontWeight.bold, fontSize: 8)),
                    ])
                  ])
            ],
          ),
        );
      },
    ),
  );
  final pdfSaved = await pdf.save();
  await Printing.layoutPdf(onLayout: (PdfPageFormat format) async => pdfSaved);
}
