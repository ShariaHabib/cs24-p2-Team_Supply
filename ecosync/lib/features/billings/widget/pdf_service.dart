import 'dart:convert';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html';
import 'dart:typed_data';
import 'dart:ui';
import 'package:syncfusion_flutter_pdf/pdf.dart';

import '../../../models/billings_model.dart';

class PdfService {
  Future<void> printCustomersPdf(BillingsModel data) async {
    PdfDocument document = PdfDocument();

    PdfPage page = document.pages.add();

    PdfBrush brush = PdfBrushes.black;
    PdfFont font = PdfStandardFont(PdfFontFamily.helvetica, 12);

    page.graphics.drawString('Billing Slip', font,
        brush: brush,
        bounds: Rect.fromLTWH(50, 50, page.getClientSize().width - 100, 20),
        format: PdfStringFormat(
            alignment: PdfTextAlignment.center,
            lineAlignment: PdfVerticalAlignment.middle));

    page.graphics.drawString('Billing Slip Id: ${data.billing_slip_id}', font,
        brush: brush,
        bounds: Rect.fromLTWH(50, 80, page.getClientSize().width - 100, 20),
        format: PdfStringFormat());

    page.graphics.drawString(
        'Landfill Entry Id: ${data.landfill_entry_id}', font,
        brush: brush,
        bounds: Rect.fromLTWH(50, 110, page.getClientSize().width - 100, 20),
        format: PdfStringFormat());

    page.graphics.drawString('Weigh of Waste: ${data.weight_of_waste}', font,
        brush: brush,
        bounds: Rect.fromLTWH(50, 140, page.getClientSize().width - 100, 20),
        format: PdfStringFormat());

    page.graphics.drawString('Fuel Cost: ${data.fuel_cost}', font,
        brush: brush,
        bounds: Rect.fromLTWH(50, 170, page.getClientSize().width - 100, 20),
        format: PdfStringFormat());

    page.graphics.drawString('Time: ${data.generated_timestamp}', font,
        brush: brush,
        bounds: Rect.fromLTWH(50, 200, page.getClientSize().width - 100, 20),
        format: PdfStringFormat());
    List<int> bytes = await document.save();

    AnchorElement(
        href:
            "data:application/octet-stream;charset=utf-16le;base64,${base64.encode(bytes)}")
      ..setAttribute("download", "slip.pdf")
      ..click();

    //Dispose the document
    document.dispose();
  }
}
